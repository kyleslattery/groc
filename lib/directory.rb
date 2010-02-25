module Groc
  class Directory
    attr_reader :path
    
    def initialize(path)
      @path = File.join(File.dirname(__FILE__), "..", "source/", path)

      raise Groc::PathNotFound if !File.exists?(@path) || File.file?(@path)
    end
  end
end