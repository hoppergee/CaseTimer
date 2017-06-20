class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

 #  cattr_accessor :current
	# before_filter { ApplicationController.current = self }
	# after_filter  { ApplicationController.current = nil  }

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
		devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
		devise_parameter_sanitizer.permit :account_update, keys: added_attrs<<:current_password
	end
end
