
#require 'test/unit'
#require 'rack/test'
#require 'sinatra'
#require 'json'
#require File.expand_path '../../min-REST-interface.rb', __FILE__
ocurrence = IO.read("../article-list.txt").scan(/^hello4\s.*\n/).size
p ocurrence
IO.write("../article-list2.txt", IO.read("../article-list.txt").gsub(/^hello.*\s.*\n/, ''))
