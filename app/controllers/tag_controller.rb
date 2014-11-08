class TagController < ApplicationController

	def index
		@tag = Tag.all.paginate(page: params[:page])
	end

	def new
	end

	def show
		@tag = Tag.find(params[:id])
		@tagged_company = Company.tagged_with(@tag.name)
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

end
