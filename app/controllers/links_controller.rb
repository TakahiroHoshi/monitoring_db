class LinksController < ApplicationController
  before_action :signed_in_user
  before_action :as_observer, only: [:new, :edit, :destroy]

  def index
    @links = Link.search(params[:search], params[:page])
  end

  def new
  	@link = Link.new(company_id: params[:company_id])
  end

  def create
  	@link = Link.new(link_params)
		if @link.save
			flash[:success] = "link successfully posted."
			redirect_to company_path(@link.company_id)
		else
			render 'new'
		end
  end

  def show
  	@link = Link.find(params[:id])
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
  	if @link.update_attributes(link_params)
  		flash[:success] = "Updated successfully."
      redirect_to company_path(@link.company_id)
  	else
  		render 'edit'
  	end
  end

  def destroy
    company_id = Link.find(params[:id]).company_id
  	Link.find(params[:id]).destroy
    flash[:success] = "Link deleted."
    redirect_to company_path(company_id)
  end

  # CSVインポート用
  def import
    # fileはtmpに自動で一時保存される
    Link.import(params[:file])
    flash[:success] = "Links imported successfully."
    redirect_to links_path
  end

  private
    def link_params
      params.require(:link).permit(:link_type, :url, :company_id)
    end

#  	def observer_user
#  		redirect_to 'show' unless current_user.observer?
#  	end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to root_path, notice: "Please sign in."
      end
    end

end
