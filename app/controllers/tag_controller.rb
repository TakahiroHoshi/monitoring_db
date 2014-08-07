class TagController < ApplicationController

	def index
		@tag = Tag.all.paginate(page: params[:page])
	end

	def new
	end

	def show
		@tag = Tag.find(params[:id])
		@company = @tag.companies.name(params[:id])
	end

	def create
	end

	def edit
	end

	def update
	end

	def destroy
	end

end
