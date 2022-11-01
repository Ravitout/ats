class Candidate < ApplicationRecord
	belongs_to :user
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true
	validates :current_location, presence: true
	validates :experience, presence: true
	validates :current_designation, presence: true
	validates :availability_for_joining, presence: true
end
