class ArticleContainer
  extend Dry::Container::Mixin
end

ArticleContainer.register :download_article_image do |url|
  open(url)
end
