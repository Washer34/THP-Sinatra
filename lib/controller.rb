require 'gossip'
class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    puts "Gossip ajouté"
    redirect '/'
  end

  get '/gossips/:id' do
    erb :show, locals: {gossip: Gossip.find(params['id']), id: params['id']}
  end

  get '/gossips/:id/edit/' do
    erb :edit, locals: {gossip: Gossip.find(params['id']), id: params['id']}
  end

  post '/gossips/:id/edit/' do
    #erb :edit, locals: {gossip: Gossip.find(params['id']), id: params['id']}
    Gossip.edit(params['id'], params["new_author"], params["new_content"])
    redirect '/'
  end

end