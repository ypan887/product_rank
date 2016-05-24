require 'rails_helper'
require 'product_hunt'
include Capybara::RSpecMatchers

describe "pages", type: :request do

  describe "visit index" do
    before :each do
      $redis.flushdb
      posts = FactoryGirl.create(:archive)
      get "/"
    end

    it "should display index page with table of posts from today" do
      expect(response).to have_http_status(200)
      expect(response).to render_template('index')
      expect(response.body).to include("#{Date.today}")
    end 

    it "should posts from yesterday at 4 posts per day" do
      expect(response.body).to include("#{Date.today.prev_day}")
      expect(response.body).to include("<option selected=\"selected\" value=\"4\">4</option>")
    end

    it "should use votes as default sort preference" do
      expect(response.body).to include("<option selected=\"selected\" value=\"votes\">votes</option>")
    end
  end

  describe "change preference" do
    before :each do
      $redis.flushdb
      posts = FactoryGirl.create(:archive)
    end

    it "should change display preference" do
      visit "/"
      find('#post_limit').find(:xpath, 'option[2]').select_option
      click_button 'Change'
      expect(page).to have_select("post_limit", :selected => "2")
    end

    it "should change sort preference" do
      visit "/"
      #find('#sort_preference').find(:xpath, 'option["comments"]',  exact: true).select_option
      select "comments", :from => "sort_preference"
      click_button 'Change'
      expect(page).to have_select("sort_preference", :selected => "comments")
    end
  end
end
