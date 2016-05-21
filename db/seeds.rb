require 'generate_data'

data = GenerateData.new.get_skimed_data("10")
data.each{ |k, v| Archive.create({date: k, posts: v}) }