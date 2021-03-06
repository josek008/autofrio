class CategoriesController < ApplicationController
	before_action :signed_in_user

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)

		if @category.save
			flash[:success] = "Categoria creada satisfactoriamente!"
			redirect_to categories_url
		else
			render 'new'
		end
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(category_params)
			flash[:success] = "Categoria actualizada."
			redirect_to categories_url
		else
			render 'edit'
		end
	end

	def destroy
		Category.find(params[:id]).destroy
		flash[:success] = "Categoria eliminada."
		redirect_to categories_url
	end

	def index
		@categories = Category.all
	end

	def show
		@category = Category.find(params[:id])
	end

	private

	def category_params
		params.require(:category).permit(:name, :photo)
	end
end
