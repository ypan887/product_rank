class PageController < ApplicationController
  require 'product_hunt'
  before_action :get_access_token, only: [:index, :products]

  def index
  end

  def products
    ProductHunt.new.handling_current_cache({ category: "tech", token: session[:access_token]})
    @products = $redis.get(:current)
  end

private

  def token_params
    ProductHunt.new.get_token
  end

  def get_access_token
    token_hash = token_params if session["access_token"].nil?
    session[:access_token] ||= token_hash["access_token"]
    session[:expire_at] = Time.current + token_hash["expires_in"]
  end
end
