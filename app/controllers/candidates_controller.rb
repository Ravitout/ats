class CandidatesController < ApplicationController
  before_action :require_login, except: [:new, :create, :show]
  # before_action :is_admin, except: [:new, :create, :show]
  # before_action :is_hr, except: [:edit]
  # before_action :is_sd, only: [:new, :create, :show]
  before_action :restrict, only: [:edit ]
	def index
		# @candidates = Candidate.search(params[:search])
    search = params[:q]
    @candidates = if search
      Candidate.where('first_name LIKE :search OR last_name LIKE :search OR current_designation LIKE :search', search: "%#{search}%")
    else
      Candidate.all
   end
	end

	def show 
    # binding.pry
		@candidate = Candidate.find(params[:id])
	end

	def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    # redirect_to message
    
    # binding.pry
    if @candidate.save
      redirect_to @candidate
      # render :show
    else  
      render :new
    end
  end

  def edit
    @candidate =  Candidate.find(params[:id])
  end

  def update
    @candidate = Candidate.find(params[:id])
    if @candidate.update(candidate_params)
      redirect_to @candidate
    else
      render :edit
    end
  end

  def destroy
      @candidate = Candidate.find(params[:id])
      @candidate.destroy
      # redirect_to candidates_path
      respond_to do |format|   
        format.html { redirect_to candidate_url, notice: "Candidate was Deleted" }   
        format.json { head :no_content }   
        format.js 
      end
  end

  private
    def candidate_params
      params.require(:candidate).permit(:first_name, :search, :last_name, :avatar, :email, :current_location, :experience, :current_designation, :availability_for_joining)
    end

    def restrict
      redirect_to root_path unless current_user.role.designation == "Director"
      flash[:notice] = "You need to be admin to edit. Please login as one"
    end

end
