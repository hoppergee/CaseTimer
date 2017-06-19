class Admin::CasesController < ApplicationController
	before_action :authenticate_user!
	before_action :require_is_super_use

	def index
		@cases = Case.where(user_id: 1)
	end

	def new
		
	end

	def create
		
	end


	def edit
		
	end

	def update
		
	end

	private

	def require_is_super_use
		current_user.is_super_admin?
	end


end
