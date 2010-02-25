require File.dirname(__FILE__) + '/spec_helper'

describe "Groc: GET file" do
  include AppHelper
  
  before(:each) do
    @page_mock = mock(Groc::Page, :body => "html")
    Groc::Page.stub!(:new).and_return(@page_mock)
  end
  
  it "should call Page.new with the path" do
    Groc::Page.should_receive(:new).with("/some/path").and_return(@page_mock)
    get '/some/path'
  end
  
  it "should return 404 if Groc::Page.new raises PathNotFound error" do
    Groc::Page.stub!(:new).and_raise(Groc::PathNotFound)
    Groc::Directory.stub!(:new).and_raise(Groc::PathNotFound)
    get '/some/path'
  end
  
  it "should output body" do
    get '/some/path'
    last_response.body.should == 'html'
  end
end

describe "Groc: GET directory" do
  include AppHelper
  
  before(:each) do
    Groc::Page.stub!(:new).and_raise(Groc::PathNotFound)
    
    @directory_mock = mock(Groc::Directory)
    Groc::Directory.stub!(:new).and_return(@directory_mock)
  end
  
  it "should call Directory.new with the path" do
    Groc::Directory.should_receive(:new).with("/some/path").and_return(@directory_mock)
    get '/some/path'
  end
  
  it "should return 404 if Groc::Directory.new raise PathNotFound error" do
    Groc::Directory.stub!(:new).and_raise(Groc::PathNotFound)
    get '/some/path'
  end
end