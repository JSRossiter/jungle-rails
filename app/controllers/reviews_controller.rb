class ReviewsController < ApplicationController
  before_filter do
    redirect_to :root unless current_user
  end

  def create
    @product = Product.find params[:product_id]
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @product
    else
      render :'products/show'
    end
  end

  def destroy
    review = Review.find params[:id]
    if current_user = review.user
      review.destroy
    end
    redirect_to review.product
  end

  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end

end
