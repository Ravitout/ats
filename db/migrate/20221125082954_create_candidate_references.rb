class CreateCandidateReferences < ActiveRecord::Migration[6.1]
  def change
    create_table :candidate_references do |t|
      t.string :name

      t.timestamps
    end
  end
end
