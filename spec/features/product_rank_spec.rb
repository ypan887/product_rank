require 'rails_helper'
require 'date'

RSpec.feature "Product Rank", :type => :feature do

  before(:each) do
    $redis.flushdb
    archive = FactoryGirl.create(:archive)
    @posts = archive.posts
  end

  scenario 'user should see list of posts and default preference settings when visiting the root', vcr:{ re_record_interval: 7.days } do
    visit root_path
    expect(page.body).to have_css("div.current .card", count: 4)
    expect(page.body).to have_css("div.archive .card")
    expect(page.body).to have_selector("form.preference")
    expect(page.body).to have_select("post_limit", :selected => "4")
    expect(page.body).to have_select("sort_preference", :selected => "votes")
    expect(@posts[2]["name"]).to appear_before(@posts[1]["name"])
  end

  scenario 'user should be able to toggle posts count preference settings on root', vcr:{ re_record_interval: 7.days } do
    visit root_path
    find('#post_limit').find(:xpath, 'option[2]').select_option
      click_button 'Change'
    expect(page.body).to have_select("post_limit", :selected => "2")
    expect(page.body).to have_css("div.current .card", count: 2)
  end

  scenario 'user should be able to toggle displacement preference settings on root', vcr:{ re_record_interval: 7.days } do
    visit root_path
    select "comments", :from => "sort_preference"
      click_button 'Change'
    expect(page).to have_select("sort_preference", :selected => "comments")
    expect(@posts[1]["name"]).to appear_before(@posts[2]["name"])
  end
end