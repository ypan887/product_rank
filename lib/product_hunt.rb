require 'httparty'
require 'redis_helper'

class ProductHunt
  include HTTParty
  include RedisHelper
  format :json
  base_uri "https://api.producthunt.com"

  def get_today_posts
    response = get_response(posts_url, token: get_token, etag: get_redis(:etag))
    set_redis(:etag, response.headers["etag"].delete('W/\"')) unless response.headers["etag"].nil?
    check_response(response)
  end

  def get_posts_x_days_ago(days)
    check_response(get_response(posts_url, query: days_query(days), token: get_token))
  end

  def get_token
    fetch_token if get_redis(:token).nil?
    get_redis(:token)
  end

  def fetch_token
    token_hash = self.class.post("/v1/oauth/token", :body => token_body, :headers => general_header)
    set_redis(:token, token_hash["access_token"])
    expire_token(token_life)
  end

private

  def posts_url
    "/v1/posts"
  end

  def token_life
    5184000
  end

  def days_query(days)
    "days_ago=#{days}"
  end
  
  def token_body
    body = {"client_id" => ENV['api_key'], "client_secret" => ENV['api_secret'], "grant_type" => "client_credentials"}.to_json
  end

  def general_header
    { 'Content-Type' => 'application/json', 'Accept' => "application/json" }
  end

  def generate_header(hash)
    general_header.merge('Authorization' => "Bearer #{hash[:token]}", 'If-None-Match' =>"#{hash[:etag]}")
  end

  def get_response(url, **options)
    self.class.get(url, :query => options[:query], :headers => generate_header(options))
  end

  def check_response(response)
    response.success?? response : nil
  end
end
