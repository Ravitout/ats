class Candidate < ApplicationRecord
	# belongs_to :user
	has_one_attached :avatar
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true
	validates :current_location, presence: true
	validates :experience, presence: true
	validates :current_designation, presence: true
	validates :availability_for_joining, presence: true

	def self.search(search)
    if search
      candidate = Candidate.find_by(first_name: search)
      if candidate
        self.where(id: candidate)
      else
        Candidate.all
      end
    else
      Candidate.all
    end
  end
end
