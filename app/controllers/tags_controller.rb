class TagsController < ApplicationController
  before_action :signed_in_user
	#before_action :observer_user, only: [:index, :search, :show]

  def index
  	@tags = Tag.all.paginate(page: params[:page])
  end

  def new
  	@tag = Tag.new
  end

  def create
  	@tag = Tag.new(tag_params)
		if @tag.save
			flash[:success] = "Tag successfully created."
			redirect_to @tag
		else
			render 'new'
		end
  end

  def show
  	@tag = Tag.find(params[:id])
  end

	def search
	end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
  	if @tag.update_attributes(tag_params)
  		flash[:success] = "Updated successfully."
  		redirect_to @tag
  	else
  		render 'edit'
  	end
  end

  def destroy
  	Tag.find(params[:id]).destroy
    flash[:success] = "Tag deleted."
    redirect_to tag_url
  end

  private
    def tag_params
      params.require(:tag).permit(:tag)
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
