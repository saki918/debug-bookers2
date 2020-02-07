class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @new_book = Book.new
    @new_bookcomment = current_user.book_comments.new(book_comment_params)
    @new_bookcomment.book_id = @book.id
    if @new_bookcomment.save
      redirect_to book_path(@book)
    else
    render 'books/show'
    end
  end
  def destroy
    @book_comment = BookComment.find_by(params[:id])
    @book_comment.destroy
    redirect_to book_path(@book_comment)
    # end
  end

    private
    def book_comment_params
        params.require(:book_comment).permit(:user_id,:book_id,:comment)
    end
end
