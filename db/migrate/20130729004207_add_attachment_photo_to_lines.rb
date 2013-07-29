class AddAttachmentPhotoToLines < ActiveRecord::Migration
  def self.up
    change_table :lines do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :lines, :photo
  end
end
