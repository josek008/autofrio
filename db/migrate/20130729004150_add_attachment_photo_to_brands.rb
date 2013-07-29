class AddAttachmentPhotoToBrands < ActiveRecord::Migration
  def self.up
    change_table :brands do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :brands, :photo
  end
end
