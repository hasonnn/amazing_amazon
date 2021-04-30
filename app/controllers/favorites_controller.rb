class FavoritesController < ApplicationController
    before_action :authenticate_user!, only:[:create, :destroy]

    def index
        @favorites = current_user.favorited_products.order('favorites.created_at DESC')
    end

    def create
        product = Product.find params[:product_id]
        favorite = Favorite.new(product: product, user: current_user)

        if !can?(:favorite, product)
            flash[:alert] = "You can't favorite your own product"
        elsif favorite.save
            flash[:notice] = "Product Favorited"
        else
            flash[:alert] = favorite.errors.full_messages.join(", ")
        end
        redirect_to product
    end

    def destroy
        favorite = Favorite.find params[:id]

        if can?(:destroy, favorite)
            favorite.destroy
            flash[:notice] = "Product Unfavorited!"
        else
            flash[:alert] = "Could not Unfavorite Product"
        end
        redirect_to favorite.product 
    end
end
