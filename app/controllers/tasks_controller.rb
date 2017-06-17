class TasksController < ApplicationController

	def index
		@case = Case.find(params[:case_id])
		@task_templates_groups = TaskTemplatesGroup.where(user: current_user, case: @case)
		# grades = Grade.where(user: current_user, case: @case)

	end



end
