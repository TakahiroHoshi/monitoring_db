class PeopleController < ApplicationController
  before_action :signed_in_user
	#before_action :observer_user, only: [:index, :search, :show]

#  def index
#  	@people = Person.all.paginate(page: params[:page])
#  end

  def new
  	@person = Person.new
  end

  def create
  	@person = Person.new(person_params)
		if @person.save
			flash[:success] = "Person successfully created."
			redirect_to @person
		else
			render 'new'
		end
  end

  def show
  	@person = Person.find(params[:id])
  end

	def search
	end

  def edit
  end

  def update
  	if @person.update_attributes(person_params)
  		flash[:success] = "Successfully updated."
  		redirect_to @person
  	else
  		render 'edit'
  	end
  end

  def destroy
  	Person.find(params[:id]).destroy
    flash[:success] = "Person deleted."
    redirect_to people_url
  end

  private
    def person_params
      params.require(:person).permit(:name, :position, :company_id)
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