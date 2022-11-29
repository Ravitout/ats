class CandidateClear < ApplicationRecord
  belongs_to :candidate
  has_one_attached :adhar_doc
  has_one_attached :pan_doc
end
