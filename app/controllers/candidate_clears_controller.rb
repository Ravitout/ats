class CandidateClearsController < ApplicationController
	before_action :fetch_id, only: [:create]
	before_action :already_submitted, only: [:create]
	def new
		@candidate_c = CandidateClear.new
	end

  def create
    @candidate_c = CandidateClear.new(candidate_clear_params)
  	# binding.pry
    if @candidate_c.save
      redirect_to root_path, notice: "Your document is submitted. We will contact you in few days"
    else  
      render :new
    end
  end

  def fetch_id
  	# binding.pry
  	@candidate_c = Candidate.find_by(email: params[:candidate_clear][:candidate_email])
  	if @candidate_c.present? && @candidate_c.status == "clear"
  		params[:candidate_clear][:candidate_id] = @candidate_c.id
  	end
  end

  def already_submitted
  	@candidate_c = CandidateClear.find_by(candidate_email: params[:candidate_clear][:candidate_email])
  	if @candidate_c.present?
  		redirect_to root_path, notice: "You have already submitted the documents."
  	end
  end

	private
    def candidate_clear_params
    	# binding.pry
      params.require(:candidate_clear).permit(:candidate_email, :adhar_card_no, :adhar_doc, :pan_card_no, :pan_doc, :candidate_id )
    end
end
