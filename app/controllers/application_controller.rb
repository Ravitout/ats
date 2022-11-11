class ApplicationController < ActionController::Base
  before_action :require_login, except: [:new, :create, :show]
  helper_method :is_admin
  helper_method :is_hr
  helper_method :is_sd

    # rescue_from_ActiveRecord: :RecordNotFound, with: :route_not_found
    # rescue_from_ActionController: :RoutingError, with: :route_not_found
    # rescue_from_ActionController: :UnknownFormat, with: :route_not_found

    def route_not_found
      render file: Rails.public_path.join('404.html'), status: :not_found
    end

  	def current_user
    	@current_user ||= User.find_by(id: session[:user_id])
  	end

  	def is_admin
      current_user.role.designation == "Director"
    end

    def is_hr
      current_user.role.designation == "Human Resource Executive"	
  	end

  	def is_sd
  		current_user.role.designation == "Sr. Software Developer"
  	end

  	def login_path
  		if is_hr
  			 candidates_path
  		else
  			root_path
  		end
  	end

    def avboii
    end

  	def require_login
    	if current_user == nil
      	flash[:error] = "You must be logged in to access this section"
      	redirect_to sign_in_url
      else
      	# redirect_to filter_user
    	end
  	end
	# end
end