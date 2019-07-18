class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end

  def slug (name)
  	return name.split.join("_")
  end

  def unslug (name)
  	return name.split("_").join(" ")
  end
end