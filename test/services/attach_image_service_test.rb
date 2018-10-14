require 'test_helper'

class AttachImageServiceTest < ActiveJob::TestCase
  test '.call' do
    article = articles(:one)

    container = Dry::Container.new

    container.register :download_article_image do |_url|
      File.new('test/fixtures/files/000000-1.png')
    end

    AttachImageService.call(article, container)

    assert { article.image.attached? }
  end
end
