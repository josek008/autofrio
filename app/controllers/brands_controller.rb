class BrandsController < ApplicationController
	before_action :signed_in_user

	def new
		@brand = Brand.new
	end

	def create
		@brand = Brand.new(brand_params)

		if @brand.save
			flash[:success] = "Marca creada satisfactoriamente!"
			redirect_to brands_url
		else
			render 'new'
		end
	end

	def edit
		@brand = Brand.find(params[:id])
	end

	def update
		@brand = Brand.find(params[:id])
		if @brand.update_attributes(brand_params)
			flash[:success] = "Marca actualizada."
			redirect_to brands_url
		else
			render 'edit'
		end
	end

	def destroy
		Brand.find(params[:id]).destroy
		flash[:success] = "Marca eliminada."
		redirect_to brands_url
	end

	def index
		@brands = Brand.all
	end

	def show
		@brand = Brand.find(params[:id])
	end

	private

	def brand_params
		params.require(:brand).permit(:name, :photo)
	end

end
