DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  
  config.before(:all) do
    begin
      DatabaseCleaner.clean
      FactoryBot.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
