
require 'test/unit'
require 'rack/test'
require 'sinatra'
require 'json'
require 'minRESTinterface'

class MyAppTest < Test::Unit::TestCase

  
  def test_cleanup_tasks
   my_article = Article.new("hello3")
   my_article.erase("hello3")
   my_article.erase("hello4")
   my_article.erase("hello")
   p 'ok'
  end
end
