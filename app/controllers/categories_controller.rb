class CategoriesController < ApplicationController

  before_filter :find_post,     only: [:show, :edit, :update, :destroy]
  before_filter :unless_admin,  only: [:index, :new, :edit, :create, :update, :destroy]

  def index
    @categories = Category.all
    @posts = Post.all
    render layout: 'admin', template: 'admin/categories'
  end

  def show
    @posts = Post.where(category_id: @category.id).order('id').paginate(:page => params[:page], :per_page => 20)
  end

  def edit
    render layout: 'admin', template: 'admin/cat_form'
  end

  def new
    @category = Category.new
    render layout: 'admin', template: 'admin/cat_form'
  end

  def create
    @category = Category.create(params[:category])

    if @category.errors.empty?
      redirect_to category_path(@category)
    else
      render "new"
    end
  end

  def update
    @category.update_attributes(params[:category])
    if @category.errors.empty?
      redirect_to category_path(@category)
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    redirect_to action: :index
  end

  private

    def find_post
      if params[:alias]
        @category = Category.where(:alias => params[:alias]).first
      else
        @category = Category.where(id: params[:id]).first
      end
#      render text: @category.id
      render_404 unless @category
    end
end
