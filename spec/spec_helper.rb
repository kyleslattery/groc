require File.join(File.dirname(__FILE__), '..', 'groc.rb')

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'spec'
require 'spec/autorun'
require 'spec/interop/test'

Dir[File.join(File.dirname(__FILE__), "..", "/lib/*.rb")].each do |path|
  require path
end

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

module PageHelper
  def new_page_with_stubs
    page_stubs!
    Groc::Page.new("/some/path")
  end
  
  def page_stubs!
    Dir.stub!(:[]).and_return(["/cool/path.md"])
    File.stub!(:file?).and_return(true)
    File.stub!(:read).and_return("content")
  end
end

module AppHelper
  include Rack::Test::Methods
  
  def app
    @app ||= Sinatra::Application
  end
end