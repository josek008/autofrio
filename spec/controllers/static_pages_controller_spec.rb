require 'spec_helper'

describe StaticPagesController do

  describe "GET 'inicio'" do
    it "returns http success" do
      get 'inicio'
      response.should be_success
    end
  end

  describe "GET 'empresa'" do
    it "returns http success" do
      get 'empresa'
      response.should be_success
    end
  end

  describe "GET 'catalogo'" do
    it "returns http success" do
      get 'catalogo'
      response.should be_success
    end
  end

  describe "GET 'contacto'" do
    it "returns http success" do
      get 'contacto'
      response.should be_success
    end
  end

  describe "GET 'admin'" do
    it "returns http success" do
      get 'admin'
      response.should be_success
    end
  end

end
