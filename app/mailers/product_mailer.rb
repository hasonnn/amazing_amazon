class ProductMailer < ApplicationMailer
    def new_product(product)
        @product = product
        @product_owner = @product.user
        mail(
            to: @product_owner.email,
            subject: "#{product.user.first_name} created a product!"
        )
    end
end
