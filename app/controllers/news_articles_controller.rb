class NewsArticlesController < ApplicationController
    before_action :find_news_article, only: [:show, :edit, :update, :destroy]

    def new
      @news_article = NewsArticle.new
    end
  
    def create
      @news_article = NewsArticle.new news_article_params
      if @news_article.save
        flash[:notice] = 'Article created!'
        redirect_to @news_article
      else
        render :new
      end
    end
  
    def show
    end
  
    def index
      @news_articles = NewsArticle.order(created_at: :desc)
    end
  
    def edit
    end
   
    def update
      if @news_article.update news_article_params
       flash[:notice] = 'Article updated!'
       redirect_to @news_article
      else
       flash[:alert] = 'Something went wrong, see errors below.'
       render :edit
      end
    end
  
    def destroy
      flash[:alert] = 'Article deleted!' if @news_article.destroy
      redirect_to news_articles_path
    end
  
    private
  
    def news_article_params
      params.require(:news_article).permit(:title, :description)
    end
  
    def find_news_article
      @news_article = NewsArticle.find params[:id]
    end
end