class CasesController < ApplicationController

	def index
		@cases = Case.all
	end

	def show
		@case = Case.find(params[:id])
		@tasks = Task.where(case_id:@case)
	end

end
