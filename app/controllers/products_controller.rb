class ProductsController < ApplicationController
  before_action :signed_in_user
  before_action :as_observer, only: [:new, :edit, :destroy]

  def index
    @products = Product.search(params[:search], params[:page])
  end

  def new
    @product = Product.new(company_id: params[:company_id])
    @hr_processes = HrProcess.all
    rev_model_list
  end

  def create
  	@product = Product.new(product_params)
    #rev_modelをドロップダウンから選択せず新規追加する場合:new_rev_modelパラメーターを使う
    @product_hr_processes = @product.product_hr_processes.build(:hr_process_id => :hr_process)
    @product.rev_model = params[:new_rev_model] unless params[:new_rev_model].empty?
		if @product.save
      @product.hr_processes << HrProcess.find(params[:hr_process])
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
    @hr_processes = HrProcess.all
    rev_model_list
  end

  def update
    @product = Product.find(params[:id])
    #:new_rev_modelに値が入力されていたら、:rev_modelに挿入する 
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
      params.require(:product).permit(:name, :description, :rev_model, :new_rev_model, :released_date, :company_id, :tag_list, 
        :hr_process_ids => [])
    end

    def hr_process_params
      params.require(:product).permit(hr_processes_attributes: [:hr_process_tag])
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


    #hr_processパラメーターのIDを取り出し、hr_processインスタンスへ代入し、product.hrprocessesに関連付けするメソッド
#    def associate_hrprocess
#      hrpparams = HrProcess.find(params [:id])
#        hrpparams.each do |hrp|
#      @product.hr_processes << params[:hr_process]
#    end

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
