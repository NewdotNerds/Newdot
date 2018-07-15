class ChangeDataTypeForSlugPosts < ActiveRecord::Migration
  def up
    change_column :posts, :slug, :text
  end

  def down
    change_column :posts, :slug, :string
  end
end
