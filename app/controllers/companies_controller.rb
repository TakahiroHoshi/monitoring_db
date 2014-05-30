class CompaniesController < ApplicationController
  before_action :signed_in_user
	#before_action :observer_user, only: [:index, :search, :show]

  def index
  	@companies = Company.paginate(page: params[:page])
  end

  def new
  	@company = Company.new
  end

  def create
  	@company = Company.new(company_params)
		if @company.save
			flash[:success] = "Company successfully created."
			redirect_to @company
		else
			render 'new'
		end
  end

  def show
  	@company = Company.find(params[:id])
    @people = @company.people.paginate(page: params[:page])
  end

	def search
	end

  def edit
    @company = Company.find(params[:id])
  end

  def update
  	if @company.update_attributes(company_params)
  		flash[:success] = "Updated successfully."
  		redirect_to @company
  	else
  		render 'edit'
  	end
  end

  def destroy
  	Company.find(params[:id]).destroy
    flash[:success] = "Company deleted."
    redirect_to companies_url
  end

  private
    def company_params
      params.require(:company).permit(:name, :description, :founded_date, :closed_date, :stage)
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
