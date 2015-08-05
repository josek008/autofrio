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
	acts_as_taggable

	has_and_belongs_to_many :lines
	has_many :brands, through: :lines
	belongs_to :category
	has_attached_file :photo, :styles => { :medium => "300x300>", :catalogue => "200x200>", :thumb => "100x100>" }, :default_url => "missing_:style.png"

	validates :category, :lines, :comments, :reference, presence: true
	validates :comments, length: { maximum: 200 }
	validates :reference, length: { maximum: 100 }
	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

	def self.search_with(word)
		self.tagged_with(word, :any => true) |
		joins(:brands, :category).
		where("products.reference LIKE ? OR products.comments LIKE ? OR brands.name LIKE ? OR lines.name LIKE ? 
				OR categories.name LIKE ?", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%").uniq
	end

	def self.available_filters(options = {})
		filtered_products = Product.filtered_by(options)
		filters = prepare_filter_options(filtered_products, options) 
		filters
	end

	def self.filtered_by(options = {})
		products = options[:category].present? ? Product.where('category_id = ?', options[:category]) : Product.all
		products = products.merge(Brand.find(options[:brand]).products) if options[:brand].present?
		products = products.merge(Line.find(options[:line]).products) if options[:line].present?
		products.uniq
	end

	def self.prepare_filter_options(products, options = {})
		filters = []
		products.each do |product|
		  filters.concat(product.brands) if options[:return_brands].present?
			filters.concat(product.lines.select { |l| l.brand == Brand.find(options[:brand]) }) if options[:return_lines].present?
		end
		filters.sort_by{|e| e[:name]}.uniq
	end
end
