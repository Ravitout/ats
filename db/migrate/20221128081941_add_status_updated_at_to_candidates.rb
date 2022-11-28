class AddStatusUpdatedAtToCandidates < ActiveRecord::Migration[6.1]
  def change
    add_column :candidates, :status_updated_at, :datetime
  end
end
