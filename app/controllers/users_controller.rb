class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :restrict, only: [:edit ]
  before_action :logged_in, except: [:index, :show, :edit, :update, :destroy, :approval, :decline]
  after_action :status_check
	def index
   # @users = User.search(
   search = params[:q]
   if require_login
    redirect_to root_path
   end
    @users = if search
      User.joins(:role).where('first_name LIKE :search OR roles.designation LIKE :search', search: "%#{search}%")
    else
      User.all
   end
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
      # binding.pry
      redirect_to new_user_path, notice: "Your request have been sent succesfully for approval"
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
    respond_to do |format|   
      format.html { redirect_to user_url, flash[:error] = "User was Deleted" }   
      format.json { head :no_content }   
      format.js 
    end
  end

  def approval
    @selected_user = User.find(params[:id])
    @selected_user.stat_approved!
    redirect_to users_path
    flash[:notice] = "Request Approved"
  end

  def decline
    @selected_user = User.find(params[:id])
    @selected_user.stat_declined!
    redirect_to users_path
    flash[:notice] = "Request Denied"
  end
      def status_check
      if current_user
        if current_user.status == "stat_pending"
          session[:user_id] = nil
          # binding.pry
          flash[:error] = "Your request is under process"
          elsif current_user.status == "stat_declined"
          flash[:notice] = "Your request is denied by Admin"
          current_user = nil
        end
      end
    end
  private
  def user_params
    params.require(:user).permit(:first_name ,:last_name, :email, :email_confirmation, :password, :role_id, :password_confirmation, :avatar)
  end
  
  def restrict
    redirect_to root_path unless current_user.role.designation == "Director"
    if !is_admin
      flash[:notice] = "You need to be admin to edit. Please login as one"
    end
  end


end

