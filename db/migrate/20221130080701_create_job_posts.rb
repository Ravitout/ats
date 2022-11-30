class CreateJobPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :job_posts do |t|
      t.integer :user_id
      t.string :job_title
      t.string :education_req
      t.string :experience_needed
      t.string :job_location
      t.string :job_type
      t.string :job_des

      t.timestamps
    end
  end
end
