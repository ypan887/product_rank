require 'rails_helper'
require 'date'

RSpec.feature "Product Rank", :type => :feature do
  scenario 'user should see list of posts and form to toggle preference settings on root', :vcr do
    visit root_path
    expect(page.body).to have_css("div.current")
    expect(page.body).to have_css("div.archive")
    expect(page).to have_selector("form.preference")
  end

  scenario 'user should see list of todays posts on root', :vcr do
    visit root_path
    expect(page).to have_title("#{DATE.current}")
  end

  scenario 'user should see list of previous posts on root', :vcr do
    visit root_path
    expect(page).to have_css(".preference")
  end

  scenario 'user should see list of product with default settings', :vcr do
    visit root_path
    expect(page).to have_css(".nested-fields")
    expect(page).to have_css(".preference")
  end
end