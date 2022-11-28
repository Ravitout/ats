class CandidatesController < ApplicationController
  before_action :require_login, except: [:new, :create, :dashboard, :edit, :modify, :update, :probing]
  before_action :status_update_check, only: [:create, :modify]
  before_action :change_update_date, only: [:update]
  before_action :restrict, only: [:edit ]
  
	def index
    if require_login
      redirect_to root_path
    end
    search = params[:q]
    @candidates = if search
      Candidate.joins(:candidate_reference).where('first_name LIKE :search OR last_name LIKE :search OR current_designation LIKE :search OR candidate_references.name LIKE :search OR status LIKE :search' , search: "%#{search}%")
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
    # binding.pry   
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      redirect_to root_path, notice: "Your application is submitted"
    else  
      render :new
    end
  end

  def edit
    # binding.pry
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

  def status_update_check
    # binding.pry
    @candidate =  Candidate.find_by(email: params[:candidate][:email])
    if @candidate.present? && @candidate.status == "rejected"
      redirect_to root_path, notice: "your application has been rejected, please try again after #{@candidate.status_updated_at + 6.months}"
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

  def change_update_date
    # binding.pry
    @candidate =  Candidate.find_by(email: params[:candidate][:email])
    if @candidate.status != params[:status]
      @candidate.update(status_updated_at: Time.now)
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
      params.require(:candidate).permit(:first_name, :search, :last_name, :avatar, :email, :current_location, :experience, :current_designation, :availability_for_joining, :security_question, :security_answer, :candidate_reference_id, :status)
    end

    def restrict
      redirect_to root_path unless current_user.role.designation == "Director" || current_user.role.designation == "Human Resource Executive"
      flash[:notice] = "You need to be admin/hr to edit. Please login as one"
    end
end
