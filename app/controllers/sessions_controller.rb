class SessionsController < ApplicationController
  before_action :is_admin

  def new
    @user = User.new  
    # debugger
  end
  def create
    if session[:user_id] != nil
      flash[:notice] = "please logout first"
      render :new
    else
      user = User.find_by(email: params[:email])
        if user.present? && user.email == params[:email] 
          password = user.password
          if password == params[:password]
            session[:user_id] = user.id
            # binding.pry
            redirect_to candidates_path, notice: "logged in successfully"
          end
        else
        flash[:notice] = "invalid email or password"
        render :new
      end
    end
  end


  def is_admin
    user = User.find_by(email: params[:email])
    if user.present? && params[:email] == user.email && user.role.designation == "Director"
      password = user.password
      if password == params[:password]
        session[:user_id] = user.id
        redirect_to users_path, notice: "logged in as admin successfully"
      end
    else
      flash[:notice] = "invalid email or password"
      render :new
    end 
  end

  def destroy
    session[:user_id] = nil
    # binding.pry
    redirect_to root_path, notice: "logged out"
  end


  private
    def current_user
     @current_user ||= User.find_by(id: session[:user_id])
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
