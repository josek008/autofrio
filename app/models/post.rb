# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  message            :string(255)
#  order              :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Post < ActiveRecord::Base
	attr_accessible :message, :order, :title, :image

	has_attached_file :image, :styles => { :large => "900x350>", :thumb => "360x140>" }, :default_url => "missing_:style.png"

	validates :title, presence: true, uniqueness: true
	validates :order, presence: true, uniqueness: true
	validates_attachment_size :image, :less_than => 5.megabytes
	validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

end
