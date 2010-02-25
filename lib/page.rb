require 'rubygems'
require 'rdiscount'

module Groc
  class Page
    attr_reader :raw_body, :path
    
    def initialize(path)
      @path = File.join(File.dirname(__FILE__), "..", "/source/", path.gsub(/\/$/, '') + ".md")
      raise PathNotFound unless File.file?(path)
      
      @raw_body = File.read(path)
    end
    
    def body
      @body ||= RDiscount.new(self.raw_body).to_html
    end
  end
end