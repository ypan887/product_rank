require 'rails_helper'

RSpec.feature "Product Rank", :type => :feature do
  scenario 'user should see list of product with default settings', :vcr do
    visit root_path
    expect(page).to have_css(".nested-fields")
  end
end