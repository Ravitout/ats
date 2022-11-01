class User < ApplicationRecord
	has_many :candidates
	belongs_to :role
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :role_id, presence: true, length: { maximum:1 }
end
