class RemoveUserIdFromCandidate < ActiveRecord::Migration[6.1]
  def change
    remove_column :candidates, :user_id, :integer
  end
end
