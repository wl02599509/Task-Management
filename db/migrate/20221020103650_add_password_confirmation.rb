class AddPasswordConfirmation < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_confirmation, :string, default: "", null: false
  end
end
