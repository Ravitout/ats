class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
	def index
		@users = User.search(params[:search])
	end
	def show 
		@user = User.find(params[:id])
	end
	def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end
    def edit
      if is_hr || is_sd
        flash[:error] = "You must be logged in as admin to access this action"
        redirect_to users_path
      else
        @user = User.find(params[:id])
      end
    end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    # redirect_to users_path
    respond_to do |format|   
      format.html { redirect_to user_url, flash[:error] = "User was Deleted" }   
      format.json { head :no_content }   
      format.js 
    end
  end
  private
   def user_params
      params.require(:user).permit(:first_name, :search ,:last_name, :email, :email_confirmation, :password, :role_id, :password_confirmation, :avatar)
   end
end

