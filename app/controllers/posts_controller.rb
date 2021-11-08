# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :load_posts, only: :index
  
  def index
    @pagy,  @posts = pagy(Post.includes(:user, :comments), page: params[:page], items: 10)
  end

  def load_posts
    PostsFacade.sync_posts_data_with_api
  end
end
