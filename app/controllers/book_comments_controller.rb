class BookCommentsController < ApplicationController
  def create#createアクションやdestroyアクションはviewに渡す必要がないため、基本的に＠いらない。ex)エラーメッセージでviewに渡す必要があれば、その行だけ＠つければよい。
  	book = Book.find(params[:book_id])#params[:モデル_id]ここはcommentコントローラなので、違うコントローラから情報を取ってくるときはこの書き方。
  	comment = BookComment.new(book_comment_params)
  	comment.user_id = current_user.id#5行目、6行目は書かなくても保存自体はできる。紐づけるのが決まり。
  	comment.book_id = book.id
  	comment.save
  	redirect_to request.referer
  end

  def destroy
  	book_comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])#(commentのidカラム：1件のコメント、commentのbook_idカラム:1件のコメントされた本）
  	book_comment.destroy
  	redirect_to request.referer
  end

  private
  def book_comment_params
  	params.require(:book_comment).permit(:comment)
  end
end
