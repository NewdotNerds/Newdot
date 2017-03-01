class AddCourseImageToTags < ActiveRecord::Migration
  def change
    add_column :tags, :course_image, :string
  end
end
