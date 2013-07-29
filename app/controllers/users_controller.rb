# encoding: UTF-8
class UsersController < ApplicationController
	before_filter :signed_in_user, 	only: [:edit, :update]
	before_filter :correct_user,	only: [:edit, :update]

	def edit
	end

	def update
		if @user.update_attributes(params[:user])
			flash[:success] = "Perfil actualizado."
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def reset_password
		if params.has_key?(:email)
			@user = User.find_by_email(params[:email])
			if @user
				@new_password = random_password
				@user.update_password(@new_password)
				UserMailer.reset_password_user(@user).deliver
				flash[:success] = "Contraseña restablecida satisfactoriamente"
				redirect_to root_url
			else
				flash[:success] = "No se encontró un usuario con la cuenta de correo electrónico ingresado. Verifique."
				redirect_to root_url
			end
		end
	end

	private 

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end

end
