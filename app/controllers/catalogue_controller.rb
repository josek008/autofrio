class CatalogueController < ApplicationController
	
	def select_category
		@categories = Category.all
	end

	def select_brand
		if Category.exists?(params[:category_id])
			@selected_category = Category.find(params[:category_id])
		else
			@selected_category = Category.new
		end
		@selected_brand = Brand.new
		@brands = Brand.all
	end

end
