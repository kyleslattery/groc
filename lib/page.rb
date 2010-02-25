require 'rubygems'
require 'rdiscount'

module Groc
  class Page
    attr_reader :raw_body
    
    def initialize(path)
      glob = File.join(File.dirname(__FILE__), "..", "/source/", path, "/**/*.md")
      path = Dir[glob].first
      raise PathNotFound unless File.file?(path)
      
      @raw_body = File.read(path)
    end
    
    def body
      @body ||= RDiscount.new(self.raw_body).to_html
    end
  end
  
  class PathNotFound < Exception; end
end