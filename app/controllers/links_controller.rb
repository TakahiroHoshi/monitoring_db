class LinksController < ApplicationController
  before_action :signed_in_user

  def index
  	@links = Link.all.paginate(page: params[:page])
  end

  def new
  	@link = Link.new
  end

  def create
  	@link = Link.new(link_params)
		if @link.save
			flash[:success] = "link successfully posted."
			redirect_to @link
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
  		redirect_to @link
  	else
  		render 'edit'
  	end
  end

  def destroy
  	Link.find(params[:id]).destroy
    flash[:success] = "Link deleted."
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
