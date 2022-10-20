class NullTrueToContent < ActiveRecord::Migration[7.0]
  def down
    change_column_null :tasks, :content, true
  end
end
