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

  def handling_current_cache(options)
    posts = get_today_posts(options)
    $redis.set(:current, posts) if posts
  end
end
