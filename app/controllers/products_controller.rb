class ProductsController < ApplicationController
  before_action :authenticate_user!   # verify the user who sign in

  def index
    @products = Product.order("id DESC")
  end

  def show
    @product = Product.find(params[:id])
  end

end
