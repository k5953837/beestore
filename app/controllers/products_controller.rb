class ProductsController < ApplicationController
  before_action :authenticate_user!   # verify the user who sign in

  def index
    @products = Product.includes(:photos).order('id DESC').page(params[:page]).per(5)
  end

  def show
    @product = Product.find(params[:id])
  end

end
