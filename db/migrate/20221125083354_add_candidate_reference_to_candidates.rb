class AddCandidateReferenceToCandidates < ActiveRecord::Migration[6.1]
  def change
    add_column :candidates, :candidate_reference_id, :integer, default: 3, null: false
  end
end
