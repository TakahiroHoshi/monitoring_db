class StaticPagesController < ApplicationController
  before_action :signed_in_user
  
  def home
  end

  def help
  end

  def about
  end

  def signup
  end

  def startsearch
    @tag = Tag.all
    @hrprocess = HrProcess.all
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to root_path, notice: "Please sign in."
      end
    end

end
