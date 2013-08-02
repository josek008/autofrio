class LinesController < ApplicationController
	#before_filter :signed_in_user

	def new
		@line = Line.new
		@brands = Brand.all
	end

	def create
		@line = Line.new(params[:line])

		if @line.save
			flash[:success] = "Linea creada satisfactoriamente!"
			redirect_to lines_url
		else
			render 'new'
		end
	end

	def edit
		@line = Line.find(params[:id])
		@brands = Brand.all
	end

	def update
		@line = Line.find(params[:id])
		if @line.update_attributes(params[:line])
			flash[:success] = "Linea actualizada."
			redirect_to lines_url
		else
			render 'edit'
		end
	end

	def destroy
		Line.find(params[:id]).destroy
		flash[:success] = "Linea eliminada."
		redirect_to lines_url
	end

	def index
		@lines = Line.all
	end

	def show
		@line = Line.find(params[:id])
	end
end
