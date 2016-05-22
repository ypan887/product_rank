class PageController < ApplicationController
  require 'product_hunt'
  before_action :get_or_set_access_token, only: [:index]

  def index
    #ProductHunt.new.handling_current_cache
    #current = $redis.get(:current)
    #@datas = Archive.paginate(page: params[:page])
    @datas = Archive.all.order('date DESC')
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
