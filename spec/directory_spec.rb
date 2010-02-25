require File.dirname(__FILE__) + '/spec_helper'

describe Groc::Directory, "attributes" do
  include DirectoryHelper
  
  before(:each) do
    @directory = new_directory_with_stubs
  end
  
  it "should have a path" do
    @directory.path.should_not be_nil
  end
  
  it "should not allow path to be set" do
    lambda {@directory.path = "asdf"}.should raise_exception(NameError)
  end
end

describe Groc::Directory, ".new" do
  include DirectoryHelper
  
  before(:each) do
    directory_stubs!
  end
  
  it "should require a path" do
    lambda {Groc::Directory.new}.should raise_exception(ArgumentError)
  end
  
  it "should raise error if the path does not exist" do
    File.stub!(:exists?).and_return(false)
    lambda {Groc::Directory.new("/some/path")}.should raise_exception(Groc::PathNotFound)
  end
  
  it "should raise error if the path exists but is a file" do
    File.stub!(:exists?).and_return(true)
    File.stub!(:file?).and_return(true)
    lambda {Groc::Directory.new("/some/path")}.should raise_exception(Groc::PathNotFound)
  end
end