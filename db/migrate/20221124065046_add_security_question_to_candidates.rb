class AddSecurityQuestionToCandidates < ActiveRecord::Migration[6.1]
  def change
    add_column :candidates, :security_question, :string
    add_column :candidates, :security_answer, :string
  end
end
