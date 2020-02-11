class FavoritesController < ApplicationController
  before_action :set_variables

  def create
    # book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    # redirect_to request.referer
  end
  def destroy
    # book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    # redirect_back fallback_location:books_path or book_path(book)
  end
  private
  def set_variables
    @book = Book.find(params[:book_id])
    @id_name = "#favorites_buttons_#{@book.id}"
  end
end
