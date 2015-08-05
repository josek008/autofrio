# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  message            :string(255)
#  priority           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Post < ActiveRecord::Base
	default_scope { order('priority ASC') }

	has_attached_file :image, :styles => { :large => "900x350>", :thumb => "360x140>" }, :default_url => "missing_:style.png"

	validates :title, presence: true, uniqueness: true
	validates :priority, presence: true, uniqueness: true
	validates_attachment_size :image, :less_than => 5.megabytes
	validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

end
