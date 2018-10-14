# frozen_string_literal: true

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    @article = articles(:one)
  end

  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'should get new' do
    get new_article_url
    assert_response :success
  end

  test 'should create article' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { body: @article.body, name: @article.name } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test 'should show article' do
    get article_url(@article)
    assert_response :success
  end

  test 'should get edit' do
    get edit_article_url(@article)
    assert_response :success
  end

  test 'should update article' do
    patch article_url(@article), params: { article: { body: @article.body, name: @article.name } }
    assert_redirected_to article_url(@article)
  end

  test 'should destroy article' do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end

  test 'should attached image' do
    perform_enqueued_jobs do
      post articles_url, params: {
        article: { body: 'body',
                   name: 'with attached image',
                   image_url: 'https://test/image.jpg' }
      }
    end

    article = Article.find_by(name: 'with attached image')

    assert { article.image.attached? }
  end
end
