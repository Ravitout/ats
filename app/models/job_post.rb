class JobPost < ApplicationRecord
	validates :job_title, presence: true
  validates :education_req, presence: true
  validates :experience_needed, presence: true
  validates :job_location, presence: true
  validates :job_type, presence: true
  validates :job_des, presence: true
	  enum status: {
    post_pending: 0, 
    post_approved: 1, 
    post_declined:2 
  }
end
