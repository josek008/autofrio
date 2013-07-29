class ProductsController < ApplicationController
	before_filter :signed_in_user, only: [:new, :create, :edit, :update, :destroy]

	def new
		@product = Product.new
		@brands = Brand.all
		@categories = Category.all
	end

	def create
		@product = Product.new(params[:product])

		if @product.save
			flash[:success] = "Producto creado satisfactoriamente!"
			redirect_to products_url
		else
			render 'new'
		end
	end

	def edit
		@product = Product.find(params[:id])
		@brands = Brand.all
		@categories = Category.all
	end

	def update
		@product = Product.find(params[:id])
		if @product.update_attributes(params[:product])
			flash[:success] = "Producto actualizado."
			redirect_to product_url
		else
			render 'edit'
		end
	end

	def destroy
		Product.find(params[:id]).destroy
		flash[:success] = "Producto eliminado."
		redirect_to product_url
	end

	def index
		@products = Product.all
	end

	def show
		@product = Product.find(params[:id])
	end
end
