class ChangeDataTypeForUsername < ActiveRecord::Migration
  def up
    change_column :users, :username, :text
  end

  def down
    change_column :users, :username, :string
  end
end
