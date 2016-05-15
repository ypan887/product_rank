require 'rails_helper'
require 'product_hunt'

describe ProductHunt do 
  describe ".get_token" do
    subject(:token_hash){ProductHunt.get_token}
    it "get access_token from product hunt api" do
      expect(token_hash).to have_key("access_token")
      expect(token_hash).to have_key("token_type")
    end
  end

  describe ".get_today_posts" do
    let(:token){ ProductHunt.get_token["access_token"]}
    subject(:product_hash){ProductHunt.get_today_posts("tech", token)}
    binding.pry
    it "get today's posts under the tech category from product hunt api" do
      expect(product_hash).to have_key("posts")
    end
  end 
end