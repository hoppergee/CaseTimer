class CasesController < ApplicationController

	def index
		@cases = Case.all
	end

	def show
		@case = Case.find(params[:id])
		# binding.pry
		@tasks = Task.where(user_id: current_user, case_id: @case)
		if @tasks.blank?
			@tasks = create_stand_task
		end
	end

	def update_timer
		# binding.pry
	end

	def create_stand_task
		jd_tasks = [{title: "第一步", description: "项目准备"},
			{title: "第二步", description: "Landingpage"},
			{title: "第三步", description: "后台搭建"}]
		tasks = []
		jd_tasks.each do |task_item|
			t= Task.create(title: task_item[:title], 
					description: task_item[:description],
					user_id: current_user.id,
					case_id: @case.id
					)
			tasks << t
		end
		return tasks
	end

end
