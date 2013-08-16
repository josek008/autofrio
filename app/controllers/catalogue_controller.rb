class CatalogueController < ApplicationController
	
	def categories
		@categories = Category.all
	end

	def brands
	end

end
