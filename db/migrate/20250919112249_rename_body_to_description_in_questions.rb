class RenameBodyToDescriptionInQuestions < ActiveRecord::Migration[8.0]
  def change
    rename_column :questions, :body, :description
  end
end
