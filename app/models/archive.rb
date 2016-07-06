require 'process_data'
class Archive < ActiveRecord::Base
  validates :date, presence: true, allow_blank: false
  validates :date, uniqueness: true
  default_scope { order('date DESC') }
end

