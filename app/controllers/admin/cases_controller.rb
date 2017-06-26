class Admin::CasesController < ApplicationController
	before_action :authenticate_user!
	before_action :require_is_super_user

	def index
		@cases = Case.where(user_id: 1)
	end

	def new
		@case = Case.new
		@group = @case.task_templates_groups.build
		@group.task_templates.build
	end

	def create
		@case = Case.new(case_params)

		if @case.save!
			redirect_to admin_cases_path
		else
			render :new
		end

	end


	def edit
		@case = Case.find(params[:id])
	end

	def update
		@case = Case.find(params[:id])
		if @case.update(case_params)
			redirect_to admin_cases_path
		else
			render :edit
		end
	end

	def destroy
		@case = Case.find(params[:id])
		@case.destroy
		redirect_to admin_cases_path
	end

	private

	def case_params
		params.require(:case).permit(:title, :user_id, :image, task_templates_groups_attributes: [:id, :user_id, :_destroy, :task_templates_attributes => [:id, :title, :_destroy]])
	end


end
