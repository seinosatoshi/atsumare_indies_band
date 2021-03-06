class CommentsController < ApplicationController
  before_action if: proc { user_signed_in? || band_signed_in? }

  def create
    @comment = Comment.new(comment_params)
    @comment.receiver_id = params[:band_id]
    if current_band
      @comment.band_id = current_band.id
    elsif current_user
      @comment.user_id = current_user.id
    end
    @comment.save
    @comments = Comment.where(receiver_id: @comment.receiver_id)
    @band_comments = Comment.where(receiver_id: @comment.receiver_id).where(user_id: nil)
    @user_comments = Comment.where(receiver_id: @comment.receiver_id).where(band_id: nil)
    flash[:success] = 'コメントが追加されました'
  end

  def destroy
    @comment = Comment.find(params[:id])
    if user_signed_in?
      if @comment.user_id == current_user.id
        @comment.destroy
      end
    elsif band_signed_in?
      if @comment.band_id == current_band.id
        @comment.destroy
      end
    end
    @comments = Comment.where(receiver_id: @comment.receiver_id)
    @band_comments = Comment.where(receiver_id: @comment.receiver_id).where(user_id: nil)
    @user_comments = Comment.where(receiver_id: @comment.receiver_id).where(band_id: nil)
    flash[:success] = 'コメントが削除されました'
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
