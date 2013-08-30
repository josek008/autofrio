# == Schema Information
#
# Table name: categories
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

class Category < ActiveRecord::Base
	attr_accessible :name, :photo

	default_scope order('name ASC')

	has_many :products, dependent: :destroy
	has_many :brands, through: :products, uniq: true
	has_many :lines, through: :brands, uniq: true

	scope :with_brand, lambda{|brand_id| where(:brands => {:id => brand_id})}

	has_attached_file :photo, :styles => { :medium => "300x300>", :catalogue => "200x200>", :thumb => "100x100>" }, :default_url => "missing_:style.png"

	validates :name, presence: true, uniqueness: true
	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
end
