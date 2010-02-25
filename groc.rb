require 'rubygems'
require 'sinatra'

Dir[File.join(File.dirname(__FILE__), "lib", "*.rb")].each do |path|
  require path
end

# For pages
get '*' do |path|
  begin
    Groc::Page.new(path).body
  rescue Groc::PathNotFound
    pass
  end
end

# For directory
get '*' do |path|
  begin
    Groc::Directory.new(path).to_s
  rescue Groc::PathNotFound
    pass
  end  
end