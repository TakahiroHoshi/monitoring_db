class ProductsController < ApplicationController
  before_action :signed_in_user
  before_action :as_observer, only: [:new, :edit, :destroy]

  def index
    @products = Product.search(params[:search], params[:page])
  end

  def new
    @product = Product.new(company_id: params[:company_id])
    all_hr_processes
    rev_model_list
  end

  def create
  	@product = Product.new(product_params)
    #rev_modelをドロップダウンから選択せず新規追加する場合:new_rev_modelパラメーターを使う
    @product.rev_model = params[:new_rev_model] unless params[:new_rev_model].empty?
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
    all_hr_processes
    rev_model_list
  end

  def update
    @product = Product.find(params[:id])
    @product.rev_model = params[:new_rev_model] unless params[:new_rev_model].empty?
  	if @product.update_attributes(product_params)
  		flash[:success] = "Updated successfully."
      redirect_to company_path(@product.company_id)
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
      params.require(:product).permit(:name, :description, :hr_process, :rev_model, :new_rev_model, :released_date, :company_id, :tag_list)
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

    #ユニークなrev_modelを並べるためのヘルパー的メソッド
    def rev_model_list
      @rev_model_list = Product.all.map{|p| p.rev_model}.uniq!.compact!
      @rev_model_list.delete("")
    end

    #ユニークなhr_processを並べるためのヘルパー的メソッド
    def all_hr_processes
      @all_hr_processes = Product.all.map{|pr| pr.hr_process}.uniq!.compact!
      @all_hr_processes.delete("")
    end

end
