require 'test_helper'

class AttachImageJobTest < ActiveJob::TestCase
  test '.perform_now' do
    stub_request(:get, 'https://test/image.jpg')
      .to_return(
        status: 200,
        body: File.new('test/fixtures/files/000000-1.png')
      )

    article = articles(:one)

    AttachImageJob.perform_now(article.id)

    assert(article.image.attached?)
  end
end
