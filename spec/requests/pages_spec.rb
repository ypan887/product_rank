require 'rails_helper'
require 'product_hunt'

describe "pages", type: :request do

  describe "visit index" do
    it "should display index page" do
      get "/"
      expect(response).to have_http_status(200)
      expect(response).to render_template('index')
    end
  end

  describe "visit product page" do
    it "should display all products" do
      get "/products"
      expect(response).to have_http_status(200)
      expect(response).to render_template('products')
    end
  end
end