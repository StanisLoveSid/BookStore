class ReviewsController < ApplicationController

  before_action :set_review, only: [:destroy, :edit, :update]
  before_action :authenticate_user!, except: [:index]

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(review_params)
    @review.user_id = current_user.id
    @review.save
    redirect_to @book
  end

  def index
    @reviews = Review.all
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :rate, :text_of_review, :book_id, :user_id)
  end

end
