class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

 #  cattr_accessor :current
	# before_filter { ApplicationController.current = self }
	# after_filter  { ApplicationController.current = nil  }
end
