class ReviewsController < ApplicationController

  before_action :set_review, only: [:destroy, :edit, :update]

  def edit
  	@book = Book.find(params[:book_id])
    @review = @book.reviews.find(params[:id])
  end

  def update
    @review.update(review_params)
    redirect_to root_path
  end

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(review_params)
    @review.save
    redirect_to @book
  end

  def destroy
    @review.destroy
    redirect_to root_path
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
