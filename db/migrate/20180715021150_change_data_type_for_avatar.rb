class ChangeDataTypeForAvatar < ActiveRecord::Migration
  def up
    change_column :users, :avatar, :text
  end

  def down
    change_column :users, :avatar, :string
  end
end
