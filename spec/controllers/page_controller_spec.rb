require 'rails_helper'

RSpec.describe PageController do
  describe "get index" do
    it "assigns @current and render index page" do
      allow(controller).to receive(:get_current_posts).and_return(1)
      get :index
      expect(assigns(:current)).to_not be_nil
      expect(response).to render_template("index")
    end
  end
end