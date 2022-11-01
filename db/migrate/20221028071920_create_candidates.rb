class CreateCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :current_designation
      t.string :current_location
      t.integer :experience
      t.date :availability_for_joining
      t.integer :user_id
      t.string :resume

      t.timestamps
    end
  end
end
