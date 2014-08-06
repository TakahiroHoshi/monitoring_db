class ProductsController < ApplicationController
  before_action :signed_in_user
	#before_action :observer_user, only: [:index, :search, :show]

  def index
  	@products = Product.all.paginate(page: params[:page])
  end

  def new
  	@product = Product.new
  end

  def create
  	@product = Product.new(product_params)
		if @product.save
			flash[:success] = "Product successfully created."
			redirect_to @product
		else
			render 'new'
		end
  end

  def show
  	@product = Product.find(params[:id])
  end

	def search
	end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
  	if @product.update_attributes(product_params)
  		flash[:success] = "Updated successfully."
  		redirect_to @product
  	else
  		render 'edit'
  	end
  end

  def destroy
  	Product.find(params[:id]).destroy
    flash[:success] = "Product deleted."
    redirect_to product_url
  end

  private
    def product_params
      params.require(:product).permit(:name, :description, :type, :released_date, :company_id)
    end

  	def observer_user
  		redirect_to 'show' unless current_user.observer?
  	end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to root_path, notice: "Please sign in."
      end
    end

end
