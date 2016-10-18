class ReviewsController < ApplicationController
  before_filter :authenticate

  def create
    @product = Product.find params[:product_id]

    @review = @product.reviews.new(review_params)

    if @review.save
      redirect_to :back, notice: 'Review added!'
    else
      render :back, notice: 'No review for you!'
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy

    redirect_to :back, notice: 'Review deleted!'
  end

  def authenticate
    session[:user_id]
  end

  private

  def review_params
    new_params = params.require(:review).permit(
                    :rating,
                    :description
                  )
    new_params[:user_id] = current_user.id
    return new_params
  end

end
