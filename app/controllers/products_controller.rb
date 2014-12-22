class ProductsController < ApplicationController
  before_action :signed_in_user
	#before_action :observer_user, only: [:index, :search, :show]

  def index
  	@products = Product.search(params[:search])
  end

  def new
    @product = Product.new(company_id: params[:company_id])
  end

  def create
  	@product = Product.new(product_params)
		if @product.save
			flash[:success] = "Product successfully created."
			redirect_to company_path(@product.company_id)
		else
			render 'new'
		end
  end

  def show
  	@product = Product.find(params[:id])
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
    company_id = Product.find(params[:id]).company_id
    Product.find(params[:id]).destroy
    flash[:success] = "Product deleted."
    redirect_to company_path(company_id)
  end

  def search
  end

  private
    def product_params
      params.require(:product).permit(:name, :description, :type, :released_date, :company_id, :tag_list)
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
