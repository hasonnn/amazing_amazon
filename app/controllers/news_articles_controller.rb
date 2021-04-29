class NewsArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_news_article, only: [:show, :edit, :update, :destroy]

    def new
      @news_article = NewsArticle.new
    end
  
    def create
      @news_article = NewsArticle.new news_article_params
      @news_article.user = current_user
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
      if can?(:edit, @news_article)
        render :edit
      else
        redirect_to news_article_path(@news_article)
      end
    end
   
    def update
      if can?(:update, @news_article)
        if @news_article.update news_article_params
          flash[:notice] = 'Article updated!'
          redirect_to @news_article
        else
          flash[:alert] = 'Something went wrong, see errors below.'
          render :edit
        end
      else
        flash[:alert] = "Not the Owner! Can't update!"
        redirect_to @news_article 
      end
    end
  
    def destroy
      if can?(:delete, @news_article)
        @news_article.destroy
        flash[:danger] = 'Article deleted!'
        redirect_to news_articles_path
      end
    end
  
    private
  
    def news_article_params
      params.require(:news_article).permit(:title, :description)
    end
  
    def find_news_article
      @news_article = NewsArticle.find params[:id]
    end
end