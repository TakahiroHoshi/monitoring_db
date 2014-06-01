class CompaniesTagsController < ApplicationController
  before_action :signed_in_user
	#before_action :observer_user, only: [:index, :search, :show]

  def index
  end

  def new
  	@companies_tag = CompaniesTag.new
  end

  def create
  	@companies_tag = CompaniesTag.new(companies_tag_params)
		if @companies_tag.save
			redirect_to @tag
		else
			render 'new'
		end
  end

  def show
  	@companies_tag = CompaniesTag.find(params[:id])
  end

	def search
	end

  def edit
    @companies_tag = CompaniesTag.find(params[:id])
  end

  def update
    @companies_tag = CompaniesTag.find(params[:id])
  	if @companies_tag.update_attributes(companies_tag_params)
  		redirect_to @companies_tag
  	else
  		render 'edit'
  	end
  end

  def destroy
  	CompaniesTag.find(params[:id]).destroy
    redirect_to tag_url
  end

  private
    def companies_tag_params
      params.require(:companies_tag).permit(:company_id, :tag_id)
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
