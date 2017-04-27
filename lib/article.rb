# -*- coding: utf-8 -*-

# Article represent a genric article and optionally his worth

class Article
 
 class << self 
  @@articles_count = 0 # articles count 
   
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
   @@articles_count += 1
   File.open("./article-list.txt", 'a+') {|f| f.write(@article.to_s +
    ' ' + @worth.to_s + "\n" ) } # appends the article to a file
   File.open("./log/LOG_DEBUG", 'a+') {|f| f.write("["+ 
   Time.now.to_s + ']'+ ' Added article: ' + @article.to_s + ' , worth: ' +
   @worth.to_s + "\n" ) }  if $DEBUG # appends the article to a log file
  end 
  
  def erase(item)
# count number of occurrences
   ocurrence = IO.read("./article-list.txt").scan(/#{item.to_s}\s.*\n/).size
   p ocurrence
   if ocurrence != 0 
    @@articles_count += ocurrence
    IO.write("./article-list2.txt", IO.read("./article-list.txt").gsub(/#{item.to_s}\s.*\n/, ''))
    IO.write("./article-list.txt", IO.read("./article-list2.txt"))  # Original regular exprtession /^#{item.to_s}\s*.\n/
     #File.open("./article-list2.txt", 'w') do |out_file|
     #File.open("./article-list.txt", 'r').each do |line|
     #out_file.print line.sub(/^#{item.to_s}\s.*\n/, '')
     #end
     #end
     #IO.write("./article-list.txt", IO.read("./article-list2.txt"))  # replace files
    File.delete("./article-list2.txt") if File.exist?("./article-list2.txt") # delete temp file
   else
    p "Nothing happens. No occurences of " + item 
   end    
  end
  
# search the article on the file 'article-list.txt'
  def find(item)
   item = item + ' ' # avoid confusion with worth value
   File.open("./article-list.txt") do |f|
   tmp = f.read(1024)
   next false if tmp.nil? # very important for empty file
   next true if tmp.include?(item)  
   until f.eof?
    tmp = tmp[(-1*item.size)..-1] + f.read(1024)
    next false if tmp.nil? # very important for empty file 
    next true if tmp.include?(item)
   end
   next false
   end
  end
  
 end
 
end
