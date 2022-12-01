class JobPostsController < ApplicationController
  before_action :login_required, only: [:new, :create, :edit, :destroy]

	# def index
	# 	@jobposts =  JobPost.all
	# end
  def index  
    if current_user == nil || current_user
    @jobposts =  JobPost.where(status: "post_approved")   
    elsif is_admin     
      @jobposts =  JobPost.all   
    end  
  end

	def new
    if current_user == nil || current_user
    elsif is_admin || is_hr
      @jobpost = JobPost.new
    end
  end

	def show 
		# binding.pry
		@jobpost = JobPost.find(params[:id])
	end

  def create
    @jobpost = JobPost.new(job_post_params)
    if @jobpost.save
      # binding.pry
      redirect_to root_path, notice: "Your Job Posting request have been sent succesfully for approval"
    else
      render :new
    end
  end

  def edit
    if is_sd || current_user == nil
      flash[:error] = "You must be logged in as admin to access this action"
      redirect_to root_path
    else
    @jobpost = JobPost.find(params[:id])
    end
  end

  def update
    @jobpost = JobPost.find(params[:id])
    if @jobpost.update(job_post_params)
      redirect_to job_posts_path, notice: "updated"
    else
      render :edit
    end
  end

  def destroy
    if is_admin
      @jobpost = JobPost.find(params[:id])
      @jobpost.destroy
      redirect_to job_posts_path, notice: "record deleted"
      return
    else
      redirect_to job_posts_path, notice: "You need to be admin for deleting"
    end
  end

  def approval
    @jobpost = JobPost.find(params[:id])
    @jobpost.post_approved!
    redirect_to job_posts_path
    flash[:notice] = "Post Approved"
  end

  def declined
    @jobpost = JobPost.find(params[:id])
    # binding.pry
    @jobpost.post_declined!
    redirect_to job_posts_path
    flash[:notice] = "Post Denied"
  end

  def login_required
    # binding.pry 
    if current_user == nil
      flash[:error] = "You must be logged in to access this section"
      redirect_to job_posts_path
    else
    end
  end


  private
    def job_post_params
    	# binding.pry
      params.require(:job_post).permit(:job_title, :user_id , :education_req, :email, :experience_needed, :job_location, :job_type, :job_des)
    end
end
