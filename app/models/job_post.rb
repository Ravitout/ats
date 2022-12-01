class JobPost < ApplicationRecord
	  enum status: {
    post_pending: 0, 
    post_approved: 1, 
    post_declined:2 
  }
end
