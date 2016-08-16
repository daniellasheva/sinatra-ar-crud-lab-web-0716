require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # get '/' do
  #
  # end

  get '/posts/new' do
    erb :new
  end

  post "/posts" do
    @post= Post.create(params)
    redirect "/posts"
  end

  get "/posts" do
    if params[:message]
      @message= params[:message]
    end
    @posts=Post.all
    erb :index
  end

  get "/posts/:id" do
    @post=Post.find(params[:id])
    erb :show
  end

  get '/posts/:id/edit' do
    #renders edit page
    #binding.pry
    @post= Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id/edit' do
    @post=Post.find(params[:id])
    @post.update(name: params[:name], content: params[:content])
    redirect "/posts/#{@post.id}"
  end

  # get '/posts/:id/delete' do
  #   @post= Post.find(params[:id])
  # end

  delete '/posts/:id/delete' do
    @post=Post.find(params[:id])
    @message= "#{@post.name} was deleted"
    @post.delete
    redirect "/posts?message=#{@message}"
  end

  #redirect from post methods and use erb show for get methods

end
