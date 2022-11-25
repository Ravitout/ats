class AddStatusToCandidate < ActiveRecord::Migration[6.1]
  def change
    add_column :candidates, :status, :string, default: "applied", null: false
  end
end
