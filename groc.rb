require 'rubygems'
require 'sinatra'
require 'lib/page'

get '*' do |path|
  begin
    Groc::Page.new(path).body
  rescue Groc::PathNotFound
    pass
  end
end