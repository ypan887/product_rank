require 'rails_helper'

RSpec.describe PageController do
  describe "get index" do
    it "assigns @current" do
      allow(controller).to receive(:get_current_posts).and_return(1)
      get :index
      expect(assigns(:current)).to_not be_nil
    end

    it "assigns @archive_posts" do
      allow(controller).to receive(:paginate_archive_posts).and_return(1)
      get :index
      expect(assigns(:archive_posts)).to_not be_nil
    end
  end
end