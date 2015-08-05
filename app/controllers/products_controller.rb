class ProductsController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]

	def new
		@product = Product.new
		@lines = Line.ordered_by_brand_name.all
		@categories = Category.all
	end

	def create
		@product = Product.new(params[:product])

		if @product.save
			flash[:success] = "Producto creado satisfactoriamente!"
			redirect_to @product
		else
			render 'new'
		end
	end

	def edit
		@product = Product.find(params[:id])
		@lines = Line.ordered_by_brand_name.all
		@categories = Category.all
	end

	def update
		@product = Product.find(params[:id])
		if @product.update_attributes(params[:product])
			flash[:success] = "Producto actualizado."
			redirect_to @product
		else
			render 'edit'
		end
	end

	def destroy
		Product.find(params[:id]).destroy
		flash[:success] = "Producto eliminado."
		redirect_to catalogo_url
	end

	def index
		@categories = Category.all

		@category = Category.find(params[:category][:id])
		@brand = Brand.find(params[:brand][:id])
		@line = Line.find(params[:line][:id])
		
		@products = Product.filtered_by({ category: @category.id, brand: @brand.id, line: @line.id }).to_a
	end

	def show
		@product = Product.find(params[:id])
		@lines = @product.lines
	end
end
