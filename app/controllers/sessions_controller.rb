class SessionsController < ApplicationController
  # after_action :status_check
  def new
    # binding.pry
    @user = User.new  
  end
  
  def create
    # binding.pry
    if session[:user_id] != nil
      flash[:notice] = "please logout first"
      render :new
    else
      user = User.find_by(email: params[:email])
      # binding.pry
        if user.present? && user.email == params[:email] 
          password = user.password
          if password == params[:password]
            if ["stat_pending", "stat_declined"].include?(user.status)
              flash[:error] = user.status == "stat_pending" ? "Your request is under process" : "Your request is denied by Admin"
              redirect_to root_path
              return
            end
            session[:user_id] = user.id
            if is_admin
              flash[:notice] = "Admin logged in"
            elsif is_hr
              flash[:notice] = "Hr logged in"
            elsif is_sd
              flash[:notice] = "Developer logged in"
            end
            redirect_to candidates_path
          end
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
    
    # def status_check
    #   if current_user
    #   if @current_user.status == "stat_pending"
    #     binding.pry
    #     flash[:error] = "Your request is under process"
    #     flash.now
    #     session[:user_id] = nil
    #   elsif @current_user.status == "stat_declined"
    #     binding.pry
    #     flash.now[:error] = "Your request is denied by Admin"
    #     session[:user_id] = nil
    #   end
    #   end
    # end

    def set_current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
end
