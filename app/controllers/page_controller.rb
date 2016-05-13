class PageController < ApplicationController
  require 'token'

  def index
    @token = Token.get_token
  end
end
