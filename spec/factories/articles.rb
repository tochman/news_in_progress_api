FactoryBot.define do
  factory :article do
    title { 'MyTitle' }
    lede { 'MyLede' }
    body { 'MyBody' }
    category { 'MyCategory' }
  end
end
