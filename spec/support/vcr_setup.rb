VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.default_cassette_options = {
    :match_requests_on => [:method, :body, :headers,
      VCR.request_matchers.uri_without_params(:url)]
  }          
end