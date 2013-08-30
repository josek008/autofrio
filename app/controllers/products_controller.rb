class ProductsController < ApplicationController
	before_filter :signed_in_user, only: [:new, :create, :edit, :update, :destroy]

	def new
		@product = Product.new
		@lines = Line.ordered_by_brand.all
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
		@lines = Line.ordered_by_brand.all
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
		redirect_to products_url
	end

	def index
		@categories = Category.all

		@selected_category = Category.find(params[:category][:id])
		@selected_brand = Brand.find(params[:brand][:id])
		@selected_line = Line.find(params[:line][:id])
		
		@products = Product.by_category(@selected_category.id).by_brand(@selected_brand.id).by_line(@selected_line.id)

	end

	def show
		@product = Product.find(params[:id])
		@lines = @product.lines
	end
end
