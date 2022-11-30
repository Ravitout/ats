class JobPostsController < ApplicationController
	def index
		@jobposts =  JobPost.all
	end

	def new
    @candidate = Candidate.new
  end

	def show 
		@jobposts = JobPost.find(params[:id])
	end

  def create
    @jobposts = JobPost.new(user_params)
    if @jobposts.save
      # binding.pry
      redirect_to root_path, notice: "Your Job Posting request have been sent succesfully for approval"
    else
      render :new
    end
  end

  def edit
    if is_sd
      flash[:error] = "You must be logged in as admin to access this action"
      redirect_to root_path
    else
      @jobposts = JobPost.find(params[:id])
    end
  end

  def update
    @jobposts = JobPost.find(params[:id])
    if @jobposts.update(user_params)
      redirect_to @jobposts
    else
      render :edit
    end
  end

  def destroy
    @jobposts = JobPost.find(params[:id])
    @jobposts.destroy
    respond_to do |format|   
      format.html { redirect_to user_url, flash[:error] = "Jobpost was Deleted" }   
      format.json { head :no_content }   
      format.js 
    end
  end
end
