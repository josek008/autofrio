class CatalogueController < ApplicationController
	
	def select_category
		@categories = Category.all
	end

	def select_brand
		@selected_category = Category.find(params[:category][:id])
		@brands = @selected_category.brands	
		@selected_brand = Brand.new
	end

	def select_line
		@selected_category = Category.find(params[:category][:id])
		@selected_brand = Brand.find(params[:brand][:id])
		@lines = @selected_category.lines.merge(Category.with_brand(@selected_brand))
		@selected_line = Line.new
	end

end
