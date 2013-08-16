# == Schema Information
#
# Table name: lines
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  brand_id           :integer
#

class Line < ActiveRecord::Base
	attr_accessible :name, :photo, :brand_id 

	belongs_to :brand
	has_and_belongs_to_many :products
	has_attached_file :photo, :styles => { :medium => "300x300>", :catalogue => "200x200>", :thumb => "100x100>" }, :default_url => "missing_:style.png"

	scope :ordered_by_brand, joins(:brand).order("brands.name ASC")

	validates :name, presence: true
	validates :brand_id, presence: true
	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

	def line_with_brand
		"#{self.brand.name} - #{self.name}"
	end

end
