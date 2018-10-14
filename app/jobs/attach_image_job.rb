class AttachImageJob < ApplicationJob
  queue_as :default

  def perform(article_id)
    article = Article.find(article_id)
    AttachImageService.call(article, ArticleContainer)
  end
end
