
require 'test/unit'
require 'rack/test'
require 'sinatra'
require 'json'
require File.expand_path '../../min-REST-interface.rb', __FILE__

class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
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
   data = '{"article": "hello"}'
   post '/article', JSON.parse(data)
   assert_equal 201, last_response.status
   assert_equal false, last_response.body.empty?
  end
  
  def test_post_full_article_valid
   data = '{"article": "hello3","worth" : "gut"}'
   post '/article', JSON.parse(data)
   assert_equal 201, last_response.status
   assert_equal false, last_response.body.empty?
   data = '{"article": "hello3","worth" : "gut", "not_be_considered": "null"}'
   post '/article', JSON.parse(data)
   assert_equal 201, last_response.status
   assert_equal false, last_response.body.empty?
  end

end
