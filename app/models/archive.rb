class Archive < ActiveRecord::Base
  validates :date, presence: true, allow_blank: false
  validates :date, uniqueness: true
  default_scope { order('date DESC') }

  def archive_yesterday
    data = GenerateData.new.get_skimed_data("1")
    data.each{ |k, v| Archive.create({date: k, posts: v}) }
  end
end
