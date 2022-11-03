class SessionsController < ApplicationController
  def new
    @user = User.new  
    # debugger
  end
  def create
    user = User.find_by(email: params[:email])
    password = user.password
    # db_user = User.where(email: "#{params[:email]}")
    # db_password = db_user.password
    # if user.present? && user.authenticate(params[:password])
    # binding.pry
    if user.present? && user.email == params[:email] && password == params[:password]
      session[user.id] = user.id
      redirect_to root_path, notice: "logged in successfully"
    else
      render :new
      flash[:alert] = "invalid user or password"
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
end
