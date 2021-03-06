class AdminController < ApplicationController

  layout 'admin'
  skip_before_filter :verify_authenticity_token

  def index
    @posts = Post.order('id DESC').paginate(:page => params[:page], :per_page => 20)
    @comments = Comment.all
    render layout: 'empty', template: 'admin/auth_form' unless session[:admin] == 1
  end

  def comments
    @comments = Comment.where("id = #{params[:id]}").order('id DESC')
  end

  def destroy_comment
    @comment = Comment.where(id: params[:id]).first
    @comment.destroy
    redirect_to action: :index
  end

  def logout
    session[:admin] = nil
    redirect_to '/'
  end

  def check
    password = ''
    if params[:password] == password
      session[:admin] = 1
      session[:try] = 0
      redirect_to '/'
    else
      render action: :index
    end
  end

end
