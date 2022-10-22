class ChangeTaskContentLimit < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks, :content, :string, :limit => 1000
  end
end
