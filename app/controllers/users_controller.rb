class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :restrict, only: [:edit ]
  before_action :logged_in, except: [:index, :show, :edit, :update, :destroy]
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

  private
    def user_params
      params.require(:user).permit(:first_name ,:last_name, :email, :email_confirmation, :password, :role_id, :password_confirmation, :avatar)
    end
    def approval
      if Candidate.find(params[:id]).status == 1
        flash[:notice] = "Your request is approved you can login"
      elsif Candidate.find(params[:id]).status == 2
        flash[:notice] = "Your registration request has been denied"
      else
        flash[:notice] = "Your request has been sent to admin for approval"
      end
      render "sign_in"
    end
    
    def restrict
      redirect_to root_path unless current_user.role.designation == "Director"
      if !is_admin
        flash[:notice] = "You need to be admin to edit. Please login as one"
      end
    end
end

