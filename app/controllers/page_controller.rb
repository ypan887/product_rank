class PageController < ApplicationController
  require 'product_hunt'

  def index
    token_hash = token_params if session["access_token"].nil?
    session[:access_token] ||= token_hash["access_token"]
    session[:expire_at] = Time.current + token_hash["expires_in"]
  end

  def products
    @porducts = ProductHunt.get_today_posts("tech")
  end

private

  def token_params
    ProductHunt.get_token
  end
end
