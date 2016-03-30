class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_name, :string
    add_index :users, :username, unique: true
  end
end
