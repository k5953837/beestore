class Admin::ProductsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!   # verify the user who sign in
  before_action :admin_required       # limit user who sign in backstage must be admin user

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @product.photos.build
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, photos_attributes: [:image])
  end
end
