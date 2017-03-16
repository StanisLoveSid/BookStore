class BooksController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @books = Book.all
    @order_item = current_order.order_items.new
    @categories = Category.all
    @sorted_books = @books.sort_by {|book| book.pick_times }.reverse
  end
  

  def new
    @book = Book.new
    @book_attachment = @book.book_attachments.build
    @categories = Category.all
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to root_path
  end

  def edit
    show
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to @book
  end
 
  def catalog
    @books = Book.all
    @a_to_z_books = @books.sort_by(&:title)
    @z_to_a_books = @a_to_z_books.reverse
    @popular_books = @books.sort_by(&:pick_times).reverse
    @newest_books = @books.order("created_at ASC")
    @low_price = @books.sort_by(&:price)
    @high_price = @low_price.reverse
  end

  def show
    @book = Book.find(params[:id])
    @book_attachments = @book.book_attachments.all
  end

  def create
    @book = current_user.books.build(book_params)
    respond_to do |format|
      if @book.save
        params[:book_attachments]['photo'].each do |foto|
          @book_attachment = @book.book_attachments.create!(:photo => foto)
        end
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private

  def book_params
    params.require(:book).permit(:year_of_publication, :materials, :dimensions,
     :category_id, :title, :description, :price, :id, 
     book_attachments_attributes: [:id, :book_id, :photo])
  end

end
