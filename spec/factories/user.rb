FactoryBot.define do
  factory :users do
    email { 'example@email.com' }
    password { '1234' }
    role { :editor }
  end
end
