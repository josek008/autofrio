# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  comments           :string(255)
#  reference          :string(255)
#  category_id        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

class Product < ActiveRecord::Base
	attr_accessible :category_id, :comments, :reference, :photo, :line_ids

	has_and_belongs_to_many :lines
	has_many :brands, through: :lines
	belongs_to :category
	has_attached_file :photo, :styles => { :medium => "300x300>", :catalogue => "200x200>", :thumb => "100x100>" }, :default_url => "missing_:style.png"

	scope :by_category, lambda{|category_id| where(:category_id => category_id) unless category_id.nil?}
	scope :by_brand, lambda{|brand_id| select("DISTINCT(products.id), products.*").
					joins(:brands).
					where(:brands => {:id => brand_id}) unless brand_id.nil?}
	scope :by_line, lambda{|line_id| where(:lines => {:id => line_id } ) unless line_id.nil?}

	validates :category_id, presence: true
	validates :comments, length: { maximum: 200 }
	validates :reference, length: { maximum: 100 }
	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

end
