RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  begin
    # Limits the available syntax to the non-monkey patched syntax that is
    # recommended. For more details, see:
    #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
    #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
    #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
    config.disable_monkey_patching!

    # Print the 10 slowest examples and example groups at the
    # end of the spec run, to help surface which specs are running
    # particularly slow.
    config.profile_examples = 10

    config.order = :random

    Kernel.srand config.seed
  end
end
