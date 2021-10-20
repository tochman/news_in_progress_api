FactoryBot.define do
  factory :user do
    email { 'example@email.com' }
    password { '123456' }
    factory  :editor do
      role { :editor }
    end
    factory :subscriber do
      role { :subscriber }
    end
  end
end
