#  App description will be here
#  2012-03-26T13:27:43
#  Rogelio Zarate

require 'sinatra/base' 
require 'ostruct' 
require 'time'

class Blog < Sinatra::Base 
# File.expand_path generates an absolute path. 
# It also takes a path as second argument. 
#The generated path is treated as being relative to that path. 

set :root, File.expand_path('../../', __FILE__)
end

