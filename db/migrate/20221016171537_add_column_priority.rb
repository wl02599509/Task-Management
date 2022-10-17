class AddColumnPriority < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :priority, :string, default: '1'
  end
end
