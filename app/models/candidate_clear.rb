class CandidateClear < ApplicationRecord
  belongs_to :candidate
  has_one_attached :adhar_doc
  has_one_attached :pan_doc
  validates :candidate_email, presence: true, email: true, uniqueness: true
  validates :adhar_card_no, presence: true
  validates :adhar_doc, presence: true
  validates :pan_card_no, presence: true
  validates :pan_doc, presence: true
end
