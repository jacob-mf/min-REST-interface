# -*- coding: utf-8 -*-

module MinRESTinterface
# min_REST_interface module project 
#  A tiny REST interface built with Sinatra framework
#Gem name 	Require statement 	Main class or module
#ruby_parser 	require 'ruby_parser' 	RubyParser
# simple_REST_interface        require 'simple_REST_interface'        SimpleRestApi
# @version 0.4.3
# @author Luis Jacob Mariscal Fernández

 require 'sinatra'
 require 'json'
 require './article.rb' # our simple article model (from Douglas)

## ArticleResource application
 class ArticleResource < Sinatra::Base
  set :methodoverride, true
 ## helpers

  def self.put_or_post(*a, &b)
    put *a , &b
    post *a , &b
  end

  helpers do
    def json_status(code, reason)
      status code
      {
        :status => code,
        :reason => reason
      }.to_json
    end

    def accept_params(params, *fields)
      h = { }
      fields.each do |name|
        h[name] = params[name] if params[name]
      end
      h
    end
  end

# simple RESTful post service to create an article from JSON object
# http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.5
#  status code {  :status => code,
#                 :reason => reason
#              }.to_json
 post '/article' do 
  content_type :json
  if  params['article'].nil?
   puts 'Bad request: article field is required in JSON'
   json_status(400, 'Bad request: article field is required in JSON')   # error code 
  else # article exists
   the_article = Article.new(params['article'],params['worth'])
  # p $DEBUG
  #p  the_article.article.empty? 
    if the_article.article.to_s.empty? # status 204 
     status 204             # if empty value '' in article
     {
      :status => 204,
      :reason => 'Warning: Nothing saved: article field is empty'
     }.to_json
    elsif the_article.find(the_article.article) # return 200 
     status 200                  # if content is already available
     {
     :status => 200,
     :reason => 'Warning: Nothing saved: article field is already stored'
      }.to_json
    else 
    the_article.save
    headers["Location"] = "/article/#{the_article.article}"
    status 201 # created, successful code
    { :article => the_article.article,
      :worth => the_article.worth }.to_json
    end 
  end
 end

 end
end
