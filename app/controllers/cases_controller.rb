require 'will_paginate/array'

class CasesController < ApplicationController

	before_action :authenticate_user!, except: [:index]

	def index
		@standard_cases = Case.where(user_id: "1")
		if current_user
			@private_cases = Case.where(user_id: current_user.id)
		end
	end

	def show
		@case = Case.find(params[:id])
		# binding.pry
		@grades = Grade.where(user_id: current_user, case_id: @case).order("created_at")
		if @grades.blank?
			official_group = TaskTemplatesGroup.where(user_id: 1, case_id: @case).first
			@templates_group = TaskTemplatesGroup.create(user: current_user, case: @case)
			official_templates = official_group.templates
			@grade = Grade.create(user: current_user, case: @case, group: @templates_group, finish: false, round: 1, round_time: 0)
			@favor = Favor.create!(user: current_user, case: @case, group: @templates_group)
			@tasks = []
			official_templates.each do |ot|
				template = ot.dup
				template.group = @templates_group
				template.save
				task = Task.create!(round: 1, task_template_id: template.id, title: template.title, description: template.description)
				@tasks << task
			end
		else
			@favor = Favor.find_by(user: current_user, case: @case)
			favor_group = @favor.group
			current_group_grades = Grade.where(user: current_user, case: @case, group: favor_group).order("created_at")
			if current_group_grades.last.finish
				# @templates_group = @favor.group
				# @task_templates = @templates_group.templates
				round = @grades.last.round + 1
				@grade = Grade.create(user: current_user, case: @case, group: favor_group, finish: false, round: round, round_time: 0)
				@tasks = []
				favor_group.templates.each do |template|
					task = Task.create!(round: round, task_template_id: template.id, title: template.title, description: template.description)
					@tasks << task
				end
			else
				@grade = current_group_grades.last
				# @templates_group = @favor.group
				@task_templates = favor_group.templates
				round = current_group_grades.last.round
				# binding.pry
				@tasks = []
				# 要拿到当前templates group下的最新未完成round，所以上一层用grades.last.finish来判断的方法，有问题，要去到task判断
				@task_templates.each do |template|
					task = Task.find_by(round: round, task_template_id: template.id)
					@tasks << task
				end
				# binding.pry
			end
		end
		@grades = Grade.where(user_id: current_user, case_id: @case, finish: true).order("updated_at")
		@task_templates_groups = TaskTemplatesGroup.where(user: current_user, case: @case)
		@current_percent = goal_percent_in(@case)
	end

	def update_goal
		@case = Case.find(params[:id])
		favor = Favor.find_by(user: current_user, case: @case)
		goal = params[:goal].to_i
		if goal > 1 && goal < 100
			favor.goal = goal
			favor.save!
		end
		current_percent = goal_percent_in(@case)

		render :json => {
			goal: favor.goal,
			current_percent: current_percent
		}
	end

	def select_template
		group = TaskTemplatesGroup.find(params[:group_id])
		@case = Case.find(params[:id])
		favor = Favor.find_by(user: current_user, case: @case)
		favor.group = group
		favor.save!
		redirect_to case_path(@case)
	end

	def update_timer
		@practice_time = params[:practice_time]
		@case = Case.find(params[:id])
		@task = Task.find(params[:task_id])
		@task.practice_time = @practice_time
		@task.save
		# favor = Favor.find_by(user: current_user, case: @case)
		@grade = Grade.find_by(user_id: current_user, case_id: @case, round: @task.round)
		@grade.round_time += @task.practice_time
		@grade.save
		if @task.siblings.last.done?
			@grade.finish = true
			@grade.save
			current_percent = goal_percent_in(@case)
			render :json => {
				practice_time: humanize(@practice_time.to_i/1000),
				task_id: @task.id,
				total_time: humanize(@grade.round_time/1000),
				current_percent: current_percent,
				finish: "恭喜，顺利完成本轮练习"
			}
		else
			render :json => {
				practice_time: humanize(@practice_time.to_i/1000),
				task_id: @task.id,
				total_time: humanize(@grade.round_time/1000),
				finish: ""
			}
		end
	end

	def ranking
		@case = Case.find(params[:id])
		users = User.all - [User.first]
		case params[:demand]
		when "round"
			@round_users = users.sort{|a,b| b.round_of(@case.id) <=> a.round_of(@case.id)}
		when "average"
			@average_users = users.sort{|a,b| a.average_time_of(@case.id) <=> b.average_time_of(@case.id)}
		when "fast"
			@fast_users = users.sort{|a,b| a.fastest_time_of(@case.id) <=> b.fastest_time_of(@case.id)}
		when "total"
			@total_users = users.sort{|a,b| b.total_time_of(@case.id) <=> a.total_time_of(@case.id)}
		else
			@round_users = users.sort{|a,b| b.round_of(@case.id) <=> a.round_of(@case.id)}[0..4]
			@average_users = users.sort{|a,b| a.average_time_of(@case.id) <=> b.average_time_of(@case.id)}[0..4]
			@fast_users = users.sort{|a,b| a.fastest_time_of(@case.id) <=> b.fastest_time_of(@case.id)}[0..4]
			@total_users = users.sort{|a,b| b.total_time_of(@case.id) <=> a.total_time_of(@case.id)}[0..4]
		end
		

	end

	def humanize(secs)
		[[60, "秒"], [60, "分"], [24, "小时"], [1000, "天"]].map{|count, name|
			if secs > 0
				secs, n = secs.divmod(count)
				"#{n.to_i} #{name}"
			end
		}.compact.reverse.join(' ')
	end

	def goal_percent_in(case_item)
		grades = Grade.where(user: current_user, case: case_item, finish: true)
		favor = Favor.find_by(user: current_user, case: case_item)
		current_percent = '%.2f' % (grades.count.to_f/favor.goal.to_f * 100)
		if current_percent.to_f >= 100
			"100%"
		else
			"#{current_percent}%"
		end
	end

end
