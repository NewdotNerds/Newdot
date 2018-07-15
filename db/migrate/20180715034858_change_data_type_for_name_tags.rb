class ChangeDataTypeForNameTags < ActiveRecord::Migration
  def up
    change_column :tags, :name, :text
  end

  def down
    change_column :tags, :name, :string
  end
end
