class ArticlesController < ApplicationController
  def index
  	if category = params[:category]
  		@articles = Article.where(category: category).order("created_at DESC")
  	else
  		@articles = Article.all.order("created_at DESC")
  	end
  end
end
