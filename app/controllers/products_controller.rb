class ProductsController < ApplicationController
    before_action :authenticate_user!, except:[:index, :show]
    before_action :find_product, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only:[:edit,:update,:destroy]

    def index
        if params[:tag]
            @tag = Tag.find_or_initialize_by(name: params[:tag])
            @products = @tag.products.all.order('updated_at DESC')
        else
            @products = Product.all.order(created_at: :desc) 
        end
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new product_params
        @product.user = current_user
        if @product.save
            ProductMailer.new_product(@product).deliver_later
            # ProductMailer.delay(run_at: 1.minutes.from_now).new_product(@product)
            flash[:notice] = "Product created successfully"
            redirect_to products_path
        else
            render :new
        end
    end

    def show
        @product = Product.find params[:id]
        @review = Review.new
        @favorite = @product.favorites.find_by_user_id current_user if user_signed_in?
    end

    def edit
    end

    def update
        if @product.update product_params
            redirect_to product_path(@product)
        else 
            render :edit
        end
    end

    def destroy
        @product.destroy
        redirect_to products_path
    end

    private

    def product_params
        params.require(:product).permit(:title, :description, :price, :tag_names)
    end
    
    def find_product
        @product = Product.find params[:id]
    end
    def authorize_user!
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @product)
    end
end

