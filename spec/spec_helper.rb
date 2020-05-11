require 'webmock/rspec'
RSpec.configure do |config|
  require 'vcr'

  VCR.configure do |c|
    c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
    c.hook_into :webmock
    c.filter_sensitive_data('<GITHUB_API_KEY>') { ENV['GITHUB_API_KEY'] }
    c.filter_sensitive_data('<MY_GITHUB_KEY>') { ENV['MY_GITHUB_KEY'] }
    c.configure_rspec_metadata!
  end

  config.before(:suite) do
     DatabaseCleaner.clean_with(:truncation)
   end

   config.before(:each) do
     DatabaseCleaner.strategy = :transaction
   end

   config.before(:each, :js => true) do
     DatabaseCleaner.strategy = :truncation
   end

   config.before(:each) do
     DatabaseCleaner.start
   end

   config.after(:each) do
     DatabaseCleaner.clean
   end

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true

  end

  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
