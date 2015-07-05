class HrProcessesController < ApplicationController
  before_action :signed_in_user
  before_action :as_observer, only: [:new, :edit, :destroy]

	def index
		@hr_processes = HrProcess.search(params[:search], params[:page])
	end

	def show
		@hr_process = HrProcess.find(params[:id])
		list_tagged_products
	end

	def new
		@hr_process = HrProcess.new
	end

	def create
		@hr_process = HrProcess.new(hr_process_params)
		if @hr_process.save
			flash[:success] = "HR Process successfully created."
			redirect_to hr_processes_path
		else
			render 'new'
		end
	end

	def edit
		@hr_process = HrProcess.find(params[:id])
	end

	def update
		@hr_process = HrProcess.find(params[:id])
		if @hr_process.update_attributes(hr_process_params)
			flash[:success] = "Updated successfully."
			redirect_to hr_process_path(params[:id])
		else
			render 'new'
		end
	end

	def destroy
		HrProcess.find(params[:id]).destroy
	  flash[:success] = "HR Process deleted."
    redirect_to hr_processes_path
	end

  # CSVインポート用
  def import
    # fileはtmpに自動で一時保存される
    HrProcess.import(params[:file])
    flash[:success] = "HR processes imported successfully."
    redirect_to hr_processes_path
  end

  private

  	#hr_process#showでタグ付けされたProductsをリスト化するためのヘルパーメソッド
		def list_tagged_products
			hrp = HrProcess.find(params[:id])
			@tagged_products = hrp.products
		end

    def hr_process_params
      params.require(:hr_process).permit(:hr_process_tag)
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
