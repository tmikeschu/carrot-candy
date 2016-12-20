DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  
  config.before(:all) do
    begin
      DatabaseCleaner.clean
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end