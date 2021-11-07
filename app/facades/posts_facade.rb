class PostsFacade 
  class << self
    def sync_posts_data_with_api
      Synchronizers::ApiSynchronizer.call() if Post.all.count.zero?
    end
  end
end
