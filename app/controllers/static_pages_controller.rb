class StaticPagesController < ApplicationController

  before_filter :signed_in_user, only: [:admin]

  def inicio
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
