class AddParamsToColumn < ActiveRecord::Migration[7.0]
  def up
    change_column_null :tasks, :title, false
    change_column_null :tasks, :content, false
    change_column :tasks, :title, :string, :limit => 50
  end
end
