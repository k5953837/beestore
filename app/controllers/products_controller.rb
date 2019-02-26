class ProductsController < ApplicationController
  before_action :authenticate_user!   # verify the user who sign in

  def index
    @products = Product.includes(:photos).order('id DESC')
  end

  def show
    @product = Product.find(params[:id])
  end

end
