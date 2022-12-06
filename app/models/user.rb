class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	belongs_to :role
 #  validates :first_name, presence: true
 #  validates :last_name, presence: true
 #  validates :email, presence: true, email:true, confirmation: true, uniqueness: true
 #  validates :email_confirmation, presence: { message: "must be given correctly" }, on: :create
 #  validates :role_id, presence: true, length: { maximum:1 }
 #  validates :password, format: {with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/, message: 'need alphabet, numbers and special characters'}, confirmation: true
 #  validates :password_confirmation, presence: { message: "must be same as password" }, on: :create
  enum status: {
    stat_pending: 0, 
    stat_approved: 1, 
    stat_declined:2 
  }
end

