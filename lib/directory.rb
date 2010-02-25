module Groc
  class Directory
    def initialize(path)
      glob = File.join(File.dirname(__FILE__), "..", "source/", path)
      dir = Dir[glob].first

      raise Groc::PathNotFound if dir.nil? || File.file?(dir)
    end
  end
end