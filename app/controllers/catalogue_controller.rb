class CatalogueController < ApplicationController
	
	def select_category
		@categories = Category.with_products
	end

	def select_brand
		@category = Category.find(params[:category][:id])
		@brand = Brand.new
		@options_for_brand = Product.available_filters({ category: @category.id, return_brands: true })
	end

	def select_line
		@category = Category.find(params[:category][:id])
		@brand = Brand.find(params[:brand][:id])
		@line = Line.new
		@options_for_line = Product.available_filters({ category: @category.id, brand: @brand.id, return_lines: true })	
	end

	def search
		@products = Product.search_with(params[:search])
	end

end
