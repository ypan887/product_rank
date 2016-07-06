require 'process_data'
class Archive < ActiveRecord::Base
  validates :date, presence: true, allow_blank: false
  validates :date, uniqueness: true
  default_scope { order('date DESC') }

  def archive_yesterday
    data = ProcessData.new.get_posts_from_yesterday_to_x_days_ago(1)
    data.each{ |k, v| Archive.create({date: k, posts: v}) }
  end
end
