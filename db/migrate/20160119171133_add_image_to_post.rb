class AddImageToPost < ActiveRecord::Migration
  def change
    add_column :posts, :image_filename, :string
  end
end
