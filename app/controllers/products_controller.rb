class ProductsController < ApplicationController
  before_action :signed_in_user
  before_action :as_observer, only: [:new, :edit, :destroy]

  def index
    @products = Product.search(params[:search], params[:page])
  end

  def new
    @product = Product.new(company_id: params[:company_id])
    @hr_processes = HrProcess.all
    @revenue_models = RevenueModel.all
    #rev_model_list
  end

  def create
  	@product = Product.new(product_params)
    @product_hr_processes = @product.product_hr_processes.build(:hr_process_id => :hr_process)
    @product_revenue_models = @product.product_revenue_models.build(:revenue_model_id => :revenue_model)
		if @product.save
=begin #以下はどうやらなくても正常に動作するらしい
      #hr_process_idsのblankを除去して@hr_process_idsへ代入
      hr_process_ids_remove_blank
      #revenue_model_idsのblankを除去して@revenue_model_idsへ代入
      revenue_model_ids_remove_blank
      #HrProcessとProductインスタンスを関連付け
      unless @hr_process_ids.nil?
        @hr_process_ids.each do |hrid|
          HrProcess.find(hrid).products << @product
        end
      end
=end
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
    @revenue_models = RevenueModel.all
    #rev_model_list
  end

  def update
    @product = Product.find(params[:id])
    @product_hr_processes = @product.product_hr_processes.build(:hr_process_id => :hr_process)
    @product_revenue_models = @product.product_revenue_models.build(:revenue_model_id => :revenue_model)
  	if @product.update_attributes(product_params)
=begin #以下はどうやらなくても正常に動作するらしい
      #hr_process_idsのblankを除去して@hr_process_idsへ代入
      hr_process_ids_remove_blank
      #revenue_model_idsのblankを除去して@revenue_model_idsへ代入
      revenue_model_ids_remove_blank
      #HrProcessとProductインスタンスを関連付け
      unless @hr_process_ids.nil?
        @hr_process_ids.each do |hrid|
          HrProcess.find(hrid).products << @product
        end
      end
=end
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

  # CSVインポート用
  def import
    # fileはtmpに自動で一時保存される
    Product.import(params[:file])
    flash[:success] = "Products imported successfully."
    redirect_to products_path
  end


  private
    def product_params
      params.require(:product).permit(:name, :description, :released_date, :company_id, :tag_list, 
        {:hr_process_ids => []}, {:revenue_model_ids => []})
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

=begin #以下はどうやらなくても正常に動作するらしい
    #hr_process_idsの空白を除外するメソッド
    def hr_process_ids_remove_blank
      @hr_process_ids = @product.hr_process_ids
      @hr_process_ids = @hr_process_ids.delete("")
    end

    #revenue_model_idsの空白を除外するメソッド
    def revenue_model_ids_remove_blank
      @revenue_model_ids = @product.revenue_model_ids
      @revenue_model_ids = @revenue_model_ids.delete("")
    end
=end

=begin #過去の遺産として一応残しているだけ
    #ユニークなrev_modelを並べるためのヘルパー的メソッド
    def rev_model_list
        @rev_model_list = Product.all.map{|p| p.rev_model}
        if @rev_model_list.empty? then
          @rev_model_lsit = nil
        elsif
          @rev_model_list.uniq!
          @rev_model_list.compact!
          @rev_model_list.delete("")
        end
    end

    #ユニークなhr_processを並べるためのヘルパー的メソッド
    def all_hr_processes
      @all_hr_processes = Product.all.map{|pr| pr.hr_process}.uniq!.compact!
      @all_hr_processes.delete("")
    end
=end

end
