class AddAttachmentPhotoToCategories < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :categories, :photo
  end
end
