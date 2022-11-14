class SessionsController < ApplicationController
# before_action :logged_in, except: [:destroy]

  def new
    # binding.pry
    @user = User.new  
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
    def dashboard
      
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
