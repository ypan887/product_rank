fake_post_1 = { "name"=>"fake_post_1", "votes_count"=>1, "comments_count"=>3, "thumbnail"=>"" }
fake_post_2 = { "name"=>"fake_post_2", "votes_count"=>2, "comments_count"=>2, "thumbnail"=>"" }
fake_post_3 = { "name"=>"fake_post_3", "votes_count"=>3, "comments_count"=>1, "thumbnail"=>"" }

FactoryGirl.define do

  sequence :date do |n|
    (n+2).days.ago
  end

  factory :archive do
    date
    posts { [fake_post_2, fake_post_1, fake_post_3] }
  end
end
