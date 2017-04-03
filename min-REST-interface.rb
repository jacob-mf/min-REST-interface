# -*- coding: utf-8 -*-

# min_REST_interface module project 
#  A tiny REST interface built with Sinatra framework
#Gem name 	Require statement 	Main class or module
#ruby_parser 	require 'ruby_parser' 	RubyParser
# simple_REST_interface        require 'simple_REST_interface'        SimpleRestApi
# @version 0.3.2
# @author Luis Jacob Mariscal Fernández

require 'sinatra'
require 'json'
#require 'article' # our simple article model (from Douglas)

# Article represent a genric article and optionally his worth
class Article
 class << self 
  @@articles_cont = 0 # articles count 
  @@debug = true # define if debug mode is on/off
  attr_accessor :article # article id
  attr_accessor :worth  # worth description
 
  # redefining create method new for Article with entry  @args[2]
  def new *args
    @article = args[0]
    @worth = args[1]
    self  # invoke initialize from the subclass
  end
  # store the Article on a file, also  if debug is on, save on LOG_DEBUG with timestamp
  def save
   @@articles_cont += 1
   File.open("./article-list.txt", 'a+') {|f| f.write(@article +
    ' ' + @worth.to_s + "\n" ) } # appends the article to a file
   File.open("./log/LOG_DEBUG", 'a+') {|f| f.write("["+ 
    Time.now.to_s + ']'+ ' Added article: ' + @article + ' , worth: ' +
    @worth.to_s + "\n" ) }  if @@debug # appends the article to a file
  end 

 end
  
 
end

# simple RESTful post service to create an article from JSON object
# http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.5
#  status code {  :status => code,
#                 :reason => reason
#              }.to_json
post '/article' do 
 content_type :json
 if params['article'].nil?
  puts 'Bad request: article field is required in JSON'
  status 400 # error code
  {
   :status => 400,
   :reason => 'Bad request: article field is required in JSON'
  }.to_json
 else # Other alternative: status 200 if content is already available, test modes e.g.
      # Other alternative: status 204 if empty value '' sent in article field
  the_article = Article.new(params['article'],params['worth']) 
  the_article.save
  headers["Location"] = "/article/#{the_article.article}"
  status 201 # created, successful code
  { :article => the_article.article,
    :worth => the_article.worth }.to_json
 end 
end
