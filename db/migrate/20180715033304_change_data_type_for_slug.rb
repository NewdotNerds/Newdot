class ChangeDataTypeForSlug < ActiveRecord::Migration
  def up
    change_column :users, :slug, :text
  end

  def down
    change_column :users, :slug, :string
  end
end
