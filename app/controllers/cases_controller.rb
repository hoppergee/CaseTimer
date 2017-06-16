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
			@grade = Grade.create(user: current_user, case: @case, finish: false, round: 1, round_time: 0)
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
			if @grades.last.finish
				@favor = Favor.find_by(user: current_user, case: @case)
				@templates_group = @favor.group
				@task_templates = @templates_group.templates
				round = @grades.last.round + 1
				@grade = Grade.create(user: current_user, case: @case, finish: false, round: round, round_time: 0)
				@tasks = []
				@task_templates.each do |template|
					task = Task.create!(round: round, task_template_id: template.id, title: template.title, description: template.description)
					@tasks << task
				end
			else
				@grade = @grades.last
				@favor = Favor.find_by(user: current_user, case: @case)
				@templates_group = @favor.group
				@task_templates = @templates_group.templates
				binding.pry
				@tasks = []
				# 要拿到当前templates group下的最新未完成round，所以上一层用grades.last.finish来判断的方法，有问题，要去到task判断
				@task_templates.each do |template|
					task = Task.find_by(round: @grades.last.round, task_template_id: template.id)
					@tasks << task
				end
				binding.pry
			end
		end
		@grades = Grade.where(user_id: current_user, case_id: @case, finish: true)
		@task_templates_groups = TaskTemplatesGroup.where(user: current_user, case: @case)
	end

	def select_template
		group = TaskTemplatesGroup.find(params[:group_id])
		@case = Case.find(params[:id])
		favor = Favor.find_by(user: current_user, case: @case)
		favor.group = group
		favor.save!
		render case_path(@case)
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
				total_time: humanize(@grade.round_time/1000),
				finish: "恭喜，全部完成"
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

	def humanize(secs)
		[[60, "秒"], [60, "分"], [24, "小时"], [1000, "天"]].map{|count, name|
			if secs > 0
				secs, n = secs.divmod(count)
				"#{n.to_i} #{name}"
			end
		}.compact.reverse.join(' ')
	end

end
