class TagController < ApplicationController
  before_action :signed_in_user
	before_action :as_observer, only: [:new, :edit, :destroy]
  
	def index
		@tag = Tag.all.paginate(page: params[:page])
	end

	def new
	end

	def show
		@tag = Tag.find(params[:id])
		@tagged_product = Product.tagged_with(@tag.name)
	end

	def create
	end

	def edit
	end

	def update
	end

	def destroy
 		Tag.find(params[:id]).destroy
    flash[:success] = "tag deleted."
    redirect_to tag_index_path
	end

  # CSVインポート用
  def import
    # fileはtmpに自動で一時保存される
    Tag.import(params[:file])
    flash[:success] = "Tags imported successfully."
    redirect_to tag_index_path
  end

	private
	  def signed_in_user
      unless signed_in?
        store_location
        redirect_to root_path, notice: "Please sign in."
      end
    end

end
