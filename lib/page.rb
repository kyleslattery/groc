require 'rubygems'
require 'rdiscount'

module Groc
  class Page
    attr_reader :raw_body
    
    def initialize(path)
      path = Dir[File.join(path, "/*.*")].first
      raise PathNotFound unless File.file?(path)
      
      @raw_body = File.read(path)
    end
    
    def body
      RDiscount.new(self.raw_body).to_html
    end
  end
  
  class PathNotFound < Exception; end
end