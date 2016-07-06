require 'rails_helper'
require 'process_data'

describe "archive_posts:save_yesterday" do
  include_context "rake"

  before do
    expect_any_instance_of(ProcessData).to receive(:archive_x_days).with(1)
  end

  it "save yesterday's posts" do
    subject.invoke
  end
end
