# Rakefile

require 'rake'
require 'rake/testtask'


Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
 at_exit { t.pattern = "test/**/cleanup.rb" if $!.nil? }
end

task :cleanup do
 Rake::TestTask.new do |t|
  t.pattern = "test/**/cleanup.rb" # Clean up tests...
 end 
end

task default: :test
