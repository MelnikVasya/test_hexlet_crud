class AttachImageJob < ApplicationJob
  queue_as :default

  def perform(article_id)
    article = Article.find(article_id)

    article.image.attach(io: open(article.image_url), filename: 'image.png')
  end
end
