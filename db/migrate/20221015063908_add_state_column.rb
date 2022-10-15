class AddStateColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :state, :string
  end
end
