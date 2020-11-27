class DeleteTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :favorites
    drop_table :post_comments
    drop_table :post_images
  end
end
