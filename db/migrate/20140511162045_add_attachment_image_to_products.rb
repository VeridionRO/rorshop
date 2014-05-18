class AddAttachmentImageToProducts < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.attachment :image
    end
  end
end
