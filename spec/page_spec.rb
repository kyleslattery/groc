require File.dirname(__FILE__) + '/spec_helper'

describe Groc::Page, "attributes" do
  include PageHelper
  
  before(:each) do
    @page = new_page_with_stubs
  end
  
  it "should not allow raw_body to be set" do
    lambda {@page.raw_body = "asdf"}.should raise_exception(NameError)
  end
  
  it "should not allow path to be set" do
    lambda {@page.path = "asdf"}.should raise_exception(NameError)
  end
  
  it "should have a raw_body" do
    @page.raw_body.should_not be_nil
  end
  
  it "should have a path" do
    @page.path.should_not be_nil
  end
end

describe Groc::Page, ".new" do
  include PageHelper
  
  before(:each) do
    page_stubs!
  end
  
  it "should require a path" do
    lambda {Groc::Page.new}.should raise_exception(ArgumentError)
  end
    
  it "should raise error if the path does not exist" do
    File.stub!(:file?).and_return(false)
    lambda {Groc::Page.new("/some/path")}.should raise_exception(Groc::PathNotFound)
  end
  
  it "should read file and put content in variable" do
    Groc::Page.new("/some/path").raw_body.should == "content"
  end
  
  it "should set path attr to the full path" do
    File.stub!(:dirname).and_return("lib")
    Groc::Page.new("/some/path").path.should == "lib/../source/some/path.md"
  end
  
  it "should prevent against ../ attacks"
end

describe Groc::Page, "#body" do
  include PageHelper
  
  before(:each) do
    @rdiscount_mock = mock(RDiscount, :to_html => "html")
    RDiscount.stub!(:new).and_return(@rdiscount_mock)
    
    @page = new_page_with_stubs
  end
  
  it "should call RDiscount.new with content of file" do
    RDiscount.should_receive(:new).with("content").and_return(@rdiscount_mock)
    @page.body
  end
  
  it "should return value of RDiscount.new.to_html" do
    @page.body.should == "html"
  end
  
  it "should cache result" do
    @page.body
    @rdiscount_mock.should_not_receive(:to_html)
    @page.body
  end
end

describe Groc::Page, "#title" do
  include PageHelper
  
  before(:each) do
    @page = new_page_with_stubs
    @page.stub!(:path)
  end
  
  it "should call File.basedir with file name and suffix"# do
    # File.should_receive(:basedir).with()
  # end
end