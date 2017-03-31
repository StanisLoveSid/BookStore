class BooksController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @books = Book.all
    @order_item = current_order.order_items.new
    @categories = Category.all
    @sorted_books = @books.sort_by {|book| book.pick_times }.reverse
  end

  def show
    @book = Book.find(params[:id])
    @book_attachments = @book.book_attachments.all
  end

end
