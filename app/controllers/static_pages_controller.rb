class StaticPagesController < ApplicationController

  before_action :signed_in_user, only: [:admin]

  def inicio
    @posts = Post.all
  end

  def empresa
  end

  def catalogo
  end

  def contacto
  end

  def admin
  end
end
