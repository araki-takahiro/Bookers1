class BooksController < ApplicationController
before_action :ensure_correct_user,only: [:edit,:update]

	def new
		@book = Book.new(user_id: current_user.id)
		@user = User.find(current_user.id)
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		@user = current_user
		@books = Book.all
		if @book.save
		redirect_to book_path(@book),notice:"successfully"
		else
		render :index
		end
	end

	def index
		@books = Book.all
		@user = current_user
		@book = Book.new
	end

	def show
		@book = Book.find(params[:id])
		@user = @book.user
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
		redirect_to book_path(@book),notice:"successfully"
		# 詳細
		else
		render :edit
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
		# 投稿一覧
	end

	private
	def book_params
		params.require(:book).permit(:title,:body)
	end
	def ensure_correct_user
		@book = Book.find(params[:id])
		if current_user.id != @book.user_id
			redirect_to books_path
		end
	end
end
