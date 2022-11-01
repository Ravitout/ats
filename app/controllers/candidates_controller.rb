class CandidatesController < ApplicationController
	def index
		@candidates = Candidate.all
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
      redirect_to @candidate
    else
      render :new
    end
  end
    def edit
    @candidate = Candidate.find(params[:id])
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

    redirect_to candidates_path
  end
  private
   def candidate_params
      params.require(:candidate).permit(:first_name, :last_name, :email, :current_location, :experience, :current_designation, :availability_for_joining, :user_id)
   end
end
