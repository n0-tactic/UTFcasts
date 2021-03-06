class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_try
  before_filter :categories

  private

    def categories
      @categories = Category.all
    end

    def render_404
      render layout: "empty", file: "public/404.html", status: 404
    end

    def render_403
      render layout: "empty", file: "public/403.html", status: 403
    end

    def check_try
      if session[:try].nil?
        session[:try] = 0
      end
      if session[:try] >= 5
        render_403
      end
    end

    def unless_admin
      unless session[:admin] == 1
        render_403
      end
    end
end
