require 'httparty'

class ProductHunt
  include HTTParty
  format :json
  base_uri "https://api.producthunt.com"

  def get_token
    fetch_token if $redis.get(:token).nil?
    $redis.get(:token)
  end

  def get_today_posts
    url = "/v1/posts"
    token = get_token
    etag = $redis.get(:etag)
    response = get_response(url, token: token, etag: etag)
    $redis.set(:etag, response.headers["etag"].delete('W/\"'))
    response
  end

  def get_posts_x_days_ago(days)
    token = get_token
    query = "days_ago=#{days}"
    url = "/v1/posts"
    get_response(url, query: query, token: token)
  end

  def get_posts_after_post_id(id)
    token = get_token
    query = "newer=#{id}"
    url = "/v1/posts/all"
    get_response(url, query: query, token: token)
  end

  def handling_current_cache
    posts = get_today_posts["posts"]
    $redis.set(:current, posts.to_json) unless posts.blank?
    $redis.expire(:current, 1200)
  end

private
  
  def get_response(url, **options)
    self.class.get( url, :query => options[:query], :headers => { 'Content-Type' => 'application/json', 'Accept' => "application/json", 'Authorization' => "Bearer #{options[:token]}", 'If-None-Match' =>"#{options[:etag]}" } )
  end

  def fetch_token
    body = {"client_id" => ENV['api_key'], "client_secret" => ENV['api_secret'], "grant_type" => "client_credentials"}.to_json
    token_hash = self.class.post("/v1/oauth/token", :body => body, :headers => { 'Content-Type' => 'application/json', 'Accept' => "application/json" })
    $redis.set(:token, token_hash["access_token"]) 
    $redis.expire(:token, token_hash["expires_in"] )
    token_hash
  end
end
