class ApplicationController < ActionController::Base
  # before_action :status_check
  
  helper_method :is_admin
  helper_method :is_hr
  helper_method :is_sd
  helper_method :current_user
  helper_method :logged_in


  def current_user
    # binding.pry
  	@current_user ||= User.find_by(id: session[:user_id])
  end

  def is_admin
    # binding.pry
    current_user.role.director?
  end

  def is_hr
    current_user.role.hr?
  end

  def is_sd
  	current_user.role.sd?
  end

  # def login_path
  # 	if is_hr
  # 		 # candidates_path
  # 	else
  # 		root_path
  # 	end
  # end

  def logged_in
    if current_user
     flash[:error] = "already logged in"
     # redirect_to root_path
    end
  end

  def require_login
  	if current_user == nil
    	# flash[:error] = "You must be logged in to access this section"
    	# redirect_to sign_in_url
    else
  	end
  end
end

