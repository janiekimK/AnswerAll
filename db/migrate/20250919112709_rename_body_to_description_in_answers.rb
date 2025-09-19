class RenameBodyToDescriptionInAnswers < ActiveRecord::Migration[8.0]
  def change
    rename_column :answers, :body, :description
  end
end
