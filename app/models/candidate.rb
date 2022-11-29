class Candidate < ApplicationRecord
	has_one :CandidateClear
	has_one_attached :avatar
	belongs_to :candidate_reference
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, email:true
	validates :current_location, presence: true
	validates :experience, presence: true
	validates :current_designation, presence: true
	validates :availability_for_joining, presence: true
	validates :avatar, presence:true
	# before_save :status_update_check
end
