FactoryBot.define do
  factory :article do
    title { 'MyTitle' }
    lede { 'MyLede' }
    body { 'MyBody' }
    category
    category_id { category.id }
    category_name { category.name} 
  end
end
