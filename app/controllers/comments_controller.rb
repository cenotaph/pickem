class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_week , :except => [:update, :publish, :cancel]
  
  def load_week
    @week = Week.find(params[:week_id])
  end
  
  def create
    @comment = Comment.new(params.require(:comment).permit(:user_id, :status, :week_id, :content, images_attributes: [:filename]))
    @comment.week = @week
    @comment.status = 'preview'
    respond_to do |format|
      if @comment.save
        format.html { redirect_to "/#{@week.season.year}/#{@week.week_number}" }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  def publish
    @comment = Comment.find(params[:id])
    @comment.status = 'published'
    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was published.'
        format.html { redirect_to "/#{@comment.week.season.year}/#{@comment.week.week_number}" }
      end
    end
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.status != 'published'
      respond_to do |format|
        if @comment.update_attributes(params.require(:comment).permit(:user_id, :status, :week_id, :content, images_attributes: [:filename]))
          flash[:notice] = 'Comment was edited.'
          format.html { redirect_to "/#{@comment.week.season.year}/#{@comment.week.week_number}" }
        end
      end      
    end
  end
  
  
  private
    
  def comment_params
    params.require(:comment).permit([:user_id, :week_id, :status, :content, :image])
  end
  
end
