class User < ApplicationRecord
  # has_secure_password
	# has_many :candidates
	belongs_to :role
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, email:true, confirmation: true, uniqueness: true
  validates :email_confirmation, presence: { message: "must be given correctly" }
  validates :role_id, presence: true, length: { maximum:1 }
  validates :password, format: {with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/, message: 'need alphabet, numbers and special characters'}, confirmation: true
  validates :password_confirmation, presence: { message: "must be same as password" }


  def self.search(search)
    if search
      User.joins(:role).where('first_name LIKE :search OR roles.designation LIKE :search', search: "%#{search}")
    else
      User.all
    end
  end
end