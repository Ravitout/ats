class ApplicationController < ActionController::Base
  before_action :require_login, except: [:new, :create, :show]
  helper_method :is_admin
  helper_method :is_hr
  helper_method :is_sd
  helper_method :current_user
  helper_method :logged_in
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
    current_user.role.director?
  end

  def is_hr
    current_user.role.hr?
  end

  def is_sd
  	current_user.role.sd?
  end

  def login_path
  	if is_hr
  		 candidates_path
  	else
  		root_path
  	end
  end

  def logged_in
    # binding.pry
    if current_user
     flash[:error] = "already logged in"
     redirect_to root_path
         # binding.pry

    end
  end

  def require_login
  	if current_user == nil
    	flash[:error] = "You must be logged in to access this section"
    	# redirect_to sign_in_url

    else
    	# redirect_to filter_user
  	end
  end
	# end
end