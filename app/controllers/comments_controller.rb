class CommentsController < ApplicationController
  http_basic_authenticate_with name: "abdul", password: "password", only: :destroy

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end
 
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

   def change
     create_table :comments do |t|
       t.string :commenter
       t.text :body
       t.references :article, index: true, foreign_key: true

       t.timestamps null: false
     end
   end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end