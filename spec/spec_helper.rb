require File.join(File.dirname(__FILE__), '..', 'groc.rb')

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'spec'
require 'spec/autorun'
require 'spec/interop/test'

Dir["../lib/*.rb"].each do |path|
  require path
end

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false