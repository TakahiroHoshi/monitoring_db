class NewsArticlesController < ApplicationController
  before_action :signed_in_user

  def index
  	@news_articles = NewsArticle.all.paginate(page: params[:page])
  end

  def new
  	@news_article = NewsArticle.new
  end

  def create
  	@news_article = NewsArticle.new(news_article_params)
		if @news_article.save
			flash[:success] = "News successfully posted."
			redirect_to @news_article
		else
			render 'new'
		end
  end

  def show
  	@news_article = NewsArticle.find(params[:id])
  end

  def edit
    @news_article = NewsArticle.find(params[:id])
  end

  def update
    @news_article = NewsArticle.find(params[:id])
  	if @news_article.update_attributes(news_article_params)
  		flash[:success] = "Updated successfully."
  		redirect_to @news_article
  	else
  		render 'edit'
  	end
  end

  def destroy
  	NewsArticle.find(params[:id]).destroy
    flash[:success] = "Link deleted."
    redirect_to news_articles_path
  end

  private
    def news_article_params
      params.require(:news_article).permit(:date, :title, :content, :comment, :publisher, :company_id, :url)
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
