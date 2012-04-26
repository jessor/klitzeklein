require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'sinatra/config_file'
#require 'json'

###

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/klitzeklein.db")

class Item
  include DataMapper::Resource

  property :url,        Text
  property :item_id,    String,     :key => true
  property :clicks,     Integer,    :default => 0
  property :created_at, DateTime
end

DataMapper.finalize
DataMapper.auto_upgrade!

###

configure do
  config_file 'config.yml'

  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', settings.api_key]
  end

  def api_request?
    request.accept == ['application/json'] or request.xhr?
  end

end

###

helpers do
  # include Rack::Utils
  alias_method :h, :escape_html

  def partial(page, options={})
    unless @partials == false
      haml page, options.merge!(:layout => false)
    end
  end

  def api_request?
    request.accept == ['application/json'] or request.xhr?
  end

  # TODO: make this smarter to have usefully shortened full urls in the view
  def shortify(s,i)
    if s.length > i
      "#{s[0..(i)]}..."
    else
      s
    end
  end
end

###

get '/' do
  redirect settings.redirect_to, 301
end

get '/items' do
  protected!

  @items = Item.all(:order => [:created_at.asc])

  if api_request?
    content_type :json
    @items.to_json
  else
    haml :index
  end
end

get '/:item_id' do |id|
  @item = Item.first(:item_id => id)
  if @item.nil?
    redirect settings.redirect_to
  else
    @item.clicks += 1
    @item.save
    redirect @item.url, 301
  end
end    

post '/items/new' do
  protected!

  @item = Item.first(:url => params['url'])

  # TODO: validate a bit
  if @item.nil?
    if params['item_id'].nil? || params['item_id'] == "items"
      o = [('a'..'z'),('0'..'9')].map{|i| i.to_a}.flatten
      begin item_id = (0..3).map{ o[rand(o.length)] }.join end until not Item.get(item_id)
    else
      item_id = params['item_id']
    end
    @item = Item.new(:url => params['url'], :item_id => item_id)
    @item.save
  end

  redirect '/items'
end
