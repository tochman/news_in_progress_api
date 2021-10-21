FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'password' }
    factory  :editor do
      role { :editor }
    end
    factory :subscriber do
      role { :subscriber }
    end
    factory :journalist do
      role { :journalist }
    end
  end
end
