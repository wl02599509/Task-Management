class AddColumnPriority < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :priority, :string, default: 'normal'
  end
end
