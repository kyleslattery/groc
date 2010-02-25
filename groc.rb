require 'rubygems'
require 'sinatra'

get '*' do |path|
  "hello world: #{path}"
end