require File.dirname(__FILE__) + '/spec_helper'

describe Groc::Page, ".new" do
  before(:each) do
    Dir.stub!(:[]).and_return(["/cool/path.md"])
    File.stub!(:file?).and_return(true)
    File.stub!(:read).and_return("content")
  end
  
  it "should require a path" do
    lambda {Groc::Page.new}.should raise_exception(ArgumentError)
  end
  
  it "should Dir[] for path/*.*" do
    Dir.should_receive(:[]).with("/some/path/*.*")
    Groc::Page.new("/some/path/")
  end
  
  it "should raise error if no file exists at that path" do
    File.stub!(:file?).and_return(false)
    lambda {Groc::Page.new("/some/path")}.should raise_exception(Groc::PathNotFound)
  end
  
  it "should read file and put content in variable" do
    Groc::Page.new("/some/path").raw_body.should == "content"
  end
  
  it "should prevent against ../ attacks"
end

describe Groc::Page, "#body" do
  before(:each) do
    Dir.stub!(:[]).and_return(["/cool/path.md"])
    File.stub!(:file?).and_return(true)
    File.stub!(:read).and_return("content")
    
    @rdiscount_mock = mock(RDiscount, :to_html => "html")
    RDiscount.stub!(:new).and_return(@rdiscount_mock)
    
    @page = Groc::Page.new("/some/path")
  end
  
  it "should call RDiscount.new with content of file" do
    RDiscount.should_receive(:new).with("content").and_return(@rdiscount_mock)
    @page.body
  end
  
  it "should return value of RDiscount.new.to_html" do
    @page.body.should == "html"
  end
end