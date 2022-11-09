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
      self.where('first_name LIKE :search OR last_name LIKE :search OR current_designation LIKE :search', search: "%#{search}")
    else
      Candidate.all
    end
  end
end
