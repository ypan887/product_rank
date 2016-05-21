require 'rails_helper'
require 'product_hunt'

describe "pages", type: :request do

  describe "visit index" do
    before :each do
      posts = FactoryGirl.create(:archive)
      get "/"
    end

    it "should display index page with table of posts" do
      expect(response).to have_http_status(200)
      expect(response).to render_template('index')
    end 
  end

end
