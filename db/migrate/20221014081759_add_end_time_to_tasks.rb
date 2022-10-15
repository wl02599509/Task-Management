class AddEndTimeToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :end_at, :datetime
  end
end
