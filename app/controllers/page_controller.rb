class PageController < ApplicationController
  require 'product_hunt'
  require 'generate_data'
  before_action :get_or_set_access_token, only: [:index]

  def index
    ProductHunt.new.handling_current_cache unless $redis.get(:current)
    data = JSON.parse($redis.get(:current))
    @current = GenerateData.new.process_data(data)
    @datas = Archive.paginate(:page => params[:page], :per_page => 5)
  end

private

  def token_params
    ProductHunt.new.get_token
  end

  def get_or_set_access_token
    token_hash = token_params if session["access_token"].nil? || session[:expire_at].nil? || session[:expire_at] < Time.current
    session[:access_token] ||= token_hash["access_token"]
  end
end
