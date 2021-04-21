class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_product, only:[:create, :destroy]

    def create
      @review = Review.new review_params
      @review.product = @product
      @review.user = current_user
      if @review.save
        redirect_to product_path(@product), notice: 'Review created!'
      else
        render '/products/show'
      end
    end

    def destroy
      @review = Review.find params[:id]
      @review.destroy
      redirect_to product_path(@product), notice: 'Review Deleted!'
    end

    private

    def find_product
      @product = Product.find params[:product_id]
    end
    
    def review_params
      params.require(:review).permit(:body, :rating)
    end
  end
  
  