class Admin::ArticlesController < ApplicationController

	before_action :require_is_super_user

	def index
	  	if category = params[:category]
	  		@articles = Article.where(category: category).order("created_at DESC")
	  	else
	  		@articles = Article.all.order("created_at DESC")
	  	end
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)

		if @article.save
			redirect_to admin_articles_path
		else
			render :new
		end
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])

		if @article.update!(article_params)
			redirect_to admin_articles_path
		else
			render :edit
		end
	end

	def destroy
		@article = Article.find(params[:id])

		@artilce.destroy

		redirect_to admin_articles_path
	end

	private

	def article_params
		params.require(:article).permit(:title,:content,:category)
	end
end
