class Role < ApplicationRecord
	has_many :users

	def director?
		designation == "Director"
	end
	def hr?
		designation == "Human Resource Executive"
	end
	def sd?
		designation == "Sr. Software Developer"
	end
end
