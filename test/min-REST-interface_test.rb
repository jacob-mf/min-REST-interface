
require 'test/unit'
require 'rack/test'
require 'sinatra'
require 'json'
require 'minRESTinterface'

class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_erase_save_articles
   my_article = Article.new("hello-this-is-new-simple-article")
   my_article.save
   assert my_article.find(my_article.article)
   my_article.erase("hello-this-is-new-simple-article") 
   assert_false my_article.find(my_article.article)
   my_article.article= "hello-this-is-new-complex-article"
   my_article.worth= "great"
   my_article.save
   assert my_article.find(my_article.article.to_s)
   my_article.erase(my_article.article.to_s)
   assert_false my_article.find(my_article.article)
  end
  
  def test_post_without_json_fail 
    post '/arte'
    assert_equal false, last_response.ok?
    assert_equal 404, last_response.status
  end
  
  def test_post_article_not_valid_format_fails
   header 'Accept', 'application/json'
   header 'Content-Type', 'application/json'
   post '/article', JSON.parse('{"articulo": "hello"}')
   assert_equal false, last_response.ok?
   fields = {
      article: 'test_reg',
      password: 'test_pass',
      email: 'test@testreg.co'
    }
    post '/article', fields 
    assert_equal false, last_response.ok?
  end 
  
  def test_post_simple_article_valid
   my_article = Article.new("hello")
   my_article.erase("hello")
   data = '{"article": "hello"}'
   post '/article', JSON.parse(data)
   assert_equal 201, last_response.status
   assert_equal false, last_response.body.empty?
  end
  
  def test_post_full_article_valid
   my_article = Article.new("hello3")
   my_article.erase("hello3")
   my_article.erase("hello4")
   data = '{"article": "hello3","worth" : "gut"}'
   post '/article', JSON.parse(data)
   assert_equal 201, last_response.status
   assert_equal false, last_response.body.empty?
   data = '{"article": "hello4","worth" : "gut", "not_be_considered": "null"}'
   post '/article', JSON.parse(data)
   assert_equal 201, last_response.status
   assert_equal false, last_response.body.empty?
  end
  
  def test_post_article_already_included
   my_article = Article.new("hello3")
   data = '{"article": "hello4","worth" : "gut","not_be_considered": "null"}' #complex, exactly same
   post '/article', JSON.parse(data)
   assert_equal 201, last_response.status
   data = '{"article": "hello3"}' # different simple
   post '/article', JSON.parse(data)
   assert_equal 201, last_response.status
   data = '{"article": "hello3","worth" : "gut"}' # same simple full
   post '/article', JSON.parse(data)
   assert_equal 200, last_response.status
   data = '{"article": "hello3","worth" : "gut","unused" : "null"}' # same more complex
   post '/article', JSON.parse(data)
   assert_equal 200, last_response.status
   my_article.erase("hello3")
   my_article.erase("hello4")
   my_article.erase("hello")
  end
end
