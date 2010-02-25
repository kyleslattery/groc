require File.dirname(__FILE__) + '/spec_helper'

describe "Groc: GET /some/path" do
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
    get '/some/path'
  end
  
  it "should output body" do
    get '/some/path'
    last_response.body.should == 'html'
  end
end