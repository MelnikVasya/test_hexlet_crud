module AttachImageService
  def self.call(article, container)
    download_image = container.resolve(:download_article_image)

    article.image.attach(
      io: download_image.call(article.image_url),
      filename: 'image.png'
    )
  end
end
