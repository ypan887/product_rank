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
    url = "/v1/categories/#{options[:category]}/posts"
    token = options[:token]
    etag = $redis.get(:etag)
    response = get_response(url, token: token, etag: etag)
    $redis.set(:etag, response.headers["etag"].delete('W/\"'))
    response
  end

  def get_posts_x_days_ago(days)
    token = get_token["access_token"]
    query = "days_ago=#{days}"
    url = "/v1/posts"
    get_response(url, query: query, token: token)
  end

  def get_posts_after_post_id(id)
    token = get_token["access_token"]
    query = "newer=#{id}"
    url = "/v1/posts/all"
    get_response(url, query: query, token: token)
  end

  def handling_current_cache(options)
    posts = get_today_posts(options)
    $redis.set(:current, posts) if posts
  end

private
  
  def get_response(url, **options)
    self.class.get( url, :query => options[:query], :headers => { 'Content-Type' => 'application/json', 'Accept' => "application/json", 'Authorization' => "Bearer #{options[:token]}", 'If-None-Match' =>"#{options[:etag]}" } )
  end
end
