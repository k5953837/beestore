class Admin::ProductsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!   # verify the user who sign in
  before_action :admin_required       # limit user who sign in backstage must be admin user

  def index
    @products = Product.includes(:photo).order('id DESC').page(params[:page]).per(5)
  end

  def new
    @product = Product.new
    @product.build_photo
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    @product.build_photo(image: params[:product][:photo])

    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def update
    @product = Product.find(params[:id])
    @product.photo.update_attribute(:image, params[:product][:photo]) if params[:product][:photo]

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :discount)
  end
end
