class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    @category.save
    redirect_to @category
  end

  def optimise(array)
    Kaminari.paginate_array(array).page(params[:page]).per(2)
  end

  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    @books = @category.books
    if params[:filter] == 'from A to Z'
      @sorted_books = optimise(@books.sort_by(&:title))
    elsif params[:filter] == 'from Z to A'
      @sorted_books = optimise(@books.sort_by(&:title).reverse)
    elsif params[:filter] == 'All'
      @sorted_books = optimise(Book.all)
    elsif params[:filter] == 'popular'
      @sorted_books = optimise(@books.sort_by(&:pick_times).reverse)
    elsif params[:filter] == 'newest'
      @sorted_books = optimise(@books.order("created_at DESC"))
    elsif params[:filter] == 'from low to high'
      @sorted_books = optimise(@books.sort_by(&:price))
    elsif params[:filter] == 'from high to low'
      @sorted_books = optimise(@books.sort_by(&:price).reverse)
    else
      @sorted_books = @books.page params[:page]
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to root_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :id)
  end

end
