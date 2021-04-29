class LikesController < ApplicationController
    before_action :authenticate_user!, only:[:create, :destroy]

    def create
        review = Review.find params[:review_id]
        like = Like.new(review: review, user: current_user)

        if !can?(:like, review)
            flash[:alert] = "You can't like your own review"
        elsif like.save
            flash[:notice] = "Review liked!"
        else
            flash[:alert] = like.errors.full.message.join(', ')
        end
        redirect_to review.product
    end

    def destroy
        like = current_user.likes.find params[:id]

        if can?(:destroy, like)
            like.destroy
            flash[:notice] = "Review Unliked!"
        else
            flash[:alert] = "Could not Unlike Review"
        end
        redirect_to like.review.product
    end
end
