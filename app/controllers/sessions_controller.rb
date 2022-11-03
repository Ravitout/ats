class SessionsController < ApplicationController
  def new
    @user = User.new  
    # debugger
  end
  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.email == params[:email] 
      password = user.password
      if password == params[:password]
        session[user.id] = user.id
        redirect_to root_path, notice: "logged in successfully"
      end
      else
        flash[:notice] = "invalid email or password"
        render :new
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
