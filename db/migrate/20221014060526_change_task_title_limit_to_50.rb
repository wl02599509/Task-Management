class ChangeTaskTitleLimitTo50 < ActiveRecord::Migration[7.0]
  def up
    change_column :tasks, :title, :string, :limit => 50
  end
end
