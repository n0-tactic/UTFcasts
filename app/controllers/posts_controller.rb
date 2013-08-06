class PostsController < ApplicationController

  require_relative 'string'

  before_filter :find_post,     only: [:show, :edit, :update, :destroy]
  before_filter :unless_admin,  only: [:new, :edit, :create, :update, :destroy, :destroy_comment]

  def index
    @posts = Post.order('id DESC').paginate(:page => params[:page], :per_page => 20)
    @category = Category.all
  end

  def show
    @category = Category.where(id: @post.category_id).first
    @comment = Comment.new
    @comments = Comment.where(post_id: @post.id).order('id DESC').paginate(:page => params[:page], :per_page => 2)
  end

  def edit
    @categories = Category.all
    render layout: 'admin', template: 'admin/form'
  end

  def new
    @post = Post.new
    @categories = Category.all
    render layout: 'admin', template: 'admin/form'
  end

  def create_comment
    @comment = Comment.new
    @comment.author = params[:comment][:author]
    @comment.comment = params[:comment][:comment]
    @comment.post_id = params[:id].to_i

    @comment.save
    redirect_to post_path(@comment.post_id)
  end

  def create
    params[:post][:need_symbols] = params[:post][:need_symbols].length
    @post = Post.create(params[:post])

    if @post.errors.empty?
      redirect_to post_path(@post)
    else
      render "new"
    end
  end

  def update
    params[:post][:need_symbols] = params[:post][:need_symbols].length unless params[:post][:need_symbols].integer?
    @post.update_attributes(params[:post])
    if @post.errors.empty?
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to action: :index
  end

  private

    def find_post
      @post = Post.where(id: params[:id]).first
      render_404 unless @post
    end

end
