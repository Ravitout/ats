class CreateCandidateClears < ActiveRecord::Migration[6.1]
  def change
    create_table :candidate_clears do |t|
      t.string :candidate_email
      t.string :candidate_id
      t.string :adhar_card_no
      t.string :pan_card_no
      t.timestamps
    end
  end
end
