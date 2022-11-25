class CandidatesController < ApplicationController
  before_action :require_login, except: [:new, :create, :dashboard, :edit, :modify, :update, :probing]
  # before_action :restrict, only: [:edit ]
  
	def index
    if require_login
      redirect_to root_path
    end
    search = params[:q]
    @candidates = if search
      Candidate.joins(:candidate_reference).where('first_name LIKE :search OR last_name LIKE :search OR current_designation LIKE :search OR candidate_references.name LIKE :search', search: "%#{search}%")
      # binding.pry
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
    # binding.pry
    if @candidate.save
      redirect_to root_path, notice: "Your application is submitted"
    else  
      render :new
    end
  end

  def edit
    binding.pry
    @candidate =  Candidate.find(params[:id])
  end

  def modify
   @candidate =  Candidate.find_by(email: params[:email])
   if @candidate.present? && @candidate.email == params[:email] && @candidate.security_question == params[:security_question] && @candidate.security_answer == params[:security_answer]
    render :edit
    return
    else
      redirect_to probing_path, notice: 'incorrect data recieved'
      return
    end    
  end

  def update
    @candidate = Candidate.find(params[:id])
    if @candidate.update(candidate_params)
      if current_user
        redirect_to candidates_path, notice: "updated"
        return
      else
        redirect_to root_path, notice: "updated"
        return
      end
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
  
  def dashboard
  end

  def probing

  end

  private
    def candidate_params
      params.require(:candidate).permit(:first_name, :search, :last_name, :avatar, :email, :current_location, :experience, :current_designation, :availability_for_joining, :security_question, :security_answer, :candidate_reference_id)
    end

    def restrict
      redirect_to root_path unless current_user.role.designation == "Director"
      flash[:notice] = "You need to be admin to edit. Please login as one"
    end
end
