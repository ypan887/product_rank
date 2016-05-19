require 'httparty'

class ProductHunt
  include HTTParty
  format :json
  base_uri "https://api.producthunt.com"

  def get_token
    body = {"client_id" => ENV['api_key'], "client_secret" => ENV['api_secret'], "grant_type" => "client_credentials"}.to_json
    self.class.post("/v1/oauth/token", :body => body, :headers => { 'Content-Type' => 'application/json', 'Accept' => "application/json" })
  end

  def get_today_posts(options)
    response = self.class.get( "/v1/categories/#{options[:category]}/posts", :headers => { 'Content-Type' => 'application/json', 'Accept' => "application/json", 'Authorization' => "Bearer #{options[:token]}", 'If-None-Match' =>"#{$redis.get(:etag)}" })
    $redis.set(:etag, response.headers["etag"].delete('W/\"'))
    response
  end

  def get_posts_x_days_ago(days)
    token = get_token["access_token"]
    query = "days_ago=#{days}"
    response = self.class.get( "/v1/posts", :query => query, :headers => { 'Content-Type' => 'application/json', 'Accept' => "application/json", 'Authorization' => "Bearer #{token}" })
  end

  def get_posts_after_post_id(id)
    token = get_token["access_token"]
    query = "newer=#{id}"
    response = self.class.get( "/v1/posts/all", :query => query, :headers => { 'Content-Type' => 'application/json', 'Accept' => "application/json", 'Authorization' => "Bearer #{token}" })
  end

  def get_first_post_id(response)
    response.values.first["id"]
  end

  def handling_current_cache(options)
    posts = get_today_posts(options)
    $redis.set(:current, posts) if posts
  end

private
  
  def get_response(url, *options)
  end
end
