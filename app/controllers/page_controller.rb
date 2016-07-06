class PageController < ApplicationController
  require 'product_hunt'
  require 'process_data'

  def index
    @current = get_current_posts
    @archive_posts = paginate_archive_posts
  end

private

  def get_current_posts
    ProcessData.new.fetch_today_posts
  end

  def paginate_archive_posts
    Archive.paginate(:page => params[:page], :per_page => 5)
  end
end
