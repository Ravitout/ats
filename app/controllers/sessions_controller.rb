class SessionsController < ApplicationController
  def new
    # binding.pry
    @user = User.new  
  end
  
  def create
    if session[:user_id] != nil
      flash[:notice] = "You are already logged in"
      render :new
    else
      user = User.find_by(email: params[:email])
        if user.present? && user.email == params[:email] && user.password == params[:password]
            if ["stat_pending", "stat_declined"].include?(user.status)
              flash[:error] = user.status == "stat_pending" ? "Your request is under process" : "Your request is denied by Admin"
              redirect_to root_path
              return
            end
            session[:user_id] = user.id
            if is_admin
              flash[:notice] = "Admin- #{user.first_name} logged in "
            elsif is_hr
              flash[:notice] = "Hr- #{user.first_name} logged in"
            elsif is_sd
              flash[:notice] = "Developer- #{user.first_name} logged in"
            end
            redirect_to candidates_path
            return
      else
        flash[:notice] = "invalid email or password"
        render :new
      end
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "logged out"
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end

    def set_current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
end
