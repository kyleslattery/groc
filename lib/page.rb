require 'rubygems'
require 'rdiscount'

module Groc
  class Page
    attr_reader :raw_body
    
    def initialize(path)
      path = Dir[File.join("source/", path, "/**/*.md")].first
      raise PathNotFound unless File.file?(path)
      
      @raw_body = File.read(path)
    end
    
    def body
      @body ||= RDiscount.new(self.raw_body).to_html
    end
  end
  
  class PathNotFound < Exception; end
end