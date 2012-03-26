#  App description will be here
#  2012-03-26T13:27:43
#  Rogelio Zarate

require 'sinatra/base' 
require 'ostruct' 
require 'time'
require 'yaml'

class Blog < Sinatra::Base 
  set :root, File.expand_path('../../', __FILE__)     # File.expand_path generates an absolute path. 
                                                      # It also takes a path as second argument. 
                                                      # The generated path is treated as being relative to that path.
                            
  set :articles, []
                                                    
  Dir.glob "#{root}/articles/*.md" do |file|          # loop through all the article files 
    
    meta, content	= File.read(file).split("\n\n", 2)  # parse meta data and content from file 
   
    article	= OpenStruct.new YAML.load(meta)          # generate a metadata object 
    
    article.date	=Time.parse article.date.to_s       # convert the date to a time object

    article.content = content                         # add the content 

    article.slug	= File.basename(file, '.md')        # generate a slug for the url 
    
   
    get "/#{article.slug}" do                         # set up the route 
      erb :post, :locals => { :article => article } 
    end
    
    
    articles << article                               # Add article to list of articles
    
    
    articles.sort_by! { |article| article.date }      # Sort articles by date, display new articles first 
    articles.reverse!
    
    get '/' do 
      erb :index
    end 
    
  end
end