require 'oauth2'
class PageController < ApplicationController

  def index
    client = OAuth2::Client.new('client_id', 'client_secret', :site => 'https://example.org')

    client.auth_code.authorize_url(:redirect_uri => 'http://localhost:8080/oauth2/callback')
  end
end
