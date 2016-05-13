require 'httparty'

class Token
  include HTTParty
  format :json

  def self.get_token
    body = {"client_id" => ENV['api_key'], "client_secret" => ENV['api_secret'], "grant_type" => "client_credentials"}.to_json
    response = post( "https://api.producthunt.com/v1/oauth/token", :body => body, :headers => { 'Content-Type' => 'application/json', 'Accept' => "application/json" })
  end
end
