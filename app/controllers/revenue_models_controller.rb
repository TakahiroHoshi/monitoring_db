class RevenueModelsController < ApplicationController
  before_action :signed_in_user
  before_action :as_observer, only: [:new, :edit, :destroy]

	def index
		@revenue_models = RevenueModel.search(params[:search], params[:page])
	end

	def show
		@revenue_model = RevenueModel.find(params[:id])
		list_tagged_products
	end

	def new
		@revenue_model = RevenueModel.new
	end

	def create
		@revenue_model = RevenueModel.new(revenue_model_params)
		if @revenue_model.save
			flash[:success] = "Revenue Model successfully created."
			redirect_to revenue_models_path
		else
			render 'new'
		end
	end

	def edit
		@revenue_model = RevenueModel.find(params[:id])
	end

	def update
		@revenue_model = RevenueModel.find(params[:id])
		if @revenue_model.update_attributes(revenue_model_params)
			flash[:success] = "Updated successfully."
			redirect_to revenue_model_path(params[:id])
		else
			render 'new'
		end
	end

	def destroy
		RevenueModel.find(params[:id]).destroy
	  flash[:success] = "Revenue Model deleted."
    redirect_to revenue_models_path
	end

  private

  	#hr_process#showでタグ付けされたProductsをリスト化するためのヘルパーメソッド
		def list_tagged_products
			revmodel = RevenueModel.find(params[:id])
			@tagged_products = revmodel.products
		end

    def revenue_model_params
      params.require(:revenue_model).permit(:rev_model)
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
