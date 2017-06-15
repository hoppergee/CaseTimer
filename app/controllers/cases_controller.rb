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
			@templates_group = TaskTemplatesGroup.where(user_id: 1, case_id: @case).first
			@task_templates = @templates_group.templates
			Grade.create(user: current_user, case: @case, finish: false, round: 1, round_time: 0)
			@tasks = []
			@task_templates.each do |template|
				task = Task.create!(round: 1, task_template_id: template.id, title: template.title, description: template.description)
				@tasks << task
			end
		else
			if @grades.last.finish
				@templates_group = TaskTemplatesGroup.where(user_id: 1, case_id: @case).first
				@task_templates = @templates_group.templates
				round = @grades.last.round + 1
				Grade.create(user: current_user, case: @case, finish: false, round: round, round_time: 0)
				@tasks = []
				@task_templates.each do |template|
					task = Task.create!(round: round, task_template_id: template.id, title: template.title, description: template.description)
					@tasks << task
				end
			else
				@templates_group = TaskTemplatesGroup.where(user_id: 1, case: @case).first
				@task_templates = @templates_group.templates
				@tasks = []
				@task_templates.each do |template|
					task = Task.find_by(round: @grades.last.round, task_template_id: template.id)
					@tasks << task
				end
			end
		end
	end

	def update_timer
		@practice_time = params[:practice_time]
		@case = Case.find(params[:id])
		@task = Task.find(params[:task_id])
		@task.practice_time = @practice_time
		@task.save
		@grade = Grade.find_by(user_id: current_user, case_id: @case, round: @task.round)
		@grade.round_time += @task.practice_time
		@grade.save
		if @task.siblings.last.done?
			@grade.finish = true
			@grade.save
			render :json => {
				practice_time: humanize(@practice_time.to_i/1000),
				task_id: @task.id,
				finish: "恭喜，全部完成"
			}
		else
			render :json => {
				practice_time: humanize(@practice_time.to_i/1000),
				task_id: @task.id,
				finish: ""
			}
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

end
