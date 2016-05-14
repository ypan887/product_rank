require 'httparty'

class ProductHunt
  include HTTParty
  format :json

  base_uri "https://api.producthunt.com"
  def self.get_token
    body = {"client_id" => ENV['api_key'], "client_secret" => ENV['api_secret'], "grant_type" => "client_credentials"}.to_json
    response = post("/v1/oauth/token", :body => body, :headers => { 'Content-Type' => 'application/json', 'Accept' => "application/json" })
  end

  def self.get_today_posts(category)
    response = post( "/v1/categories/#{category}/posts", :headers => { 'Content-Type' => 'application/json', 'Accept' => "application/json", 'Authorization' => "Bearer #{session[:access_token]}" })
  end
end
