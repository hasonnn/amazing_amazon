class ReviewMailer < ApplicationMailer
    def new_review(review)
        @review = review
        @product = review.product
        @product_owner = @product.user
        mail(
            to: @product_owner.email,
            subject: "You've received a review from #{review.user.first_name}"
        )
    end
end
