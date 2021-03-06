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
	has_many :products, dependent: :destroy

	has_attached_file :photo, :styles => { :medium => "300x300>", :catalogue => "200x200>", :thumb => "100x100>" }, :default_url => "missing_:style.png"

	validates :name, presence: true, uniqueness: true
	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

	default_scope { order('name ASC') }
	scope :with_products, -> { select { |category| category.products.count > 0 } }
end
