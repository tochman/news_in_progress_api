FactoryBot.define do
  factory :article do
    title { 'MyTitle' }
    lede { 'MyLede' }
    main_image { 'MainImage' }
    url { 'url.com' }
    # date { 2021-10-13 }
    body { 'MyBody' }
  end
end
