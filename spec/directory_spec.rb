require File.dirname(__FILE__) + '/spec_helper'

describe Groc::Directory, ".new" do
  include DirectoryHelper
  
  before(:each) do
    directory_stubs!
  end
  
  it "should require a path" do
    lambda {Groc::Directory.new}.should raise_exception(ArgumentError)
  end
  
  it "should Dir[] for the path" do
    File.stub!(:dirname).and_return("lib")
    Dir.should_receive(:[]).with("lib/../source/some/path").and_return(["asdf"])
    Groc::Directory.new("/some/path")
  end
  
  it "should raise error if the path does not exist" do
    Dir.stub!(:[]).and_return([])
    lambda {Groc::Directory.new("/some/path")}.should raise_exception(Groc::PathNotFound)
  end
  
  it "should raise error if the path is a file" do
    File.stub!(:file?).and_return(true)
    lambda {Groc::Directory.new("/some/path")}.should raise_exception(Groc::PathNotFound)
  end
end