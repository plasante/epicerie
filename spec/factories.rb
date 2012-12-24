FactoryGirl.define do
#  factory :user do
#    first_name    "Pierre"
#    last_name     "Lasante"
#    username      "plasante"
#    email         "plasante@email.com"
#    password      "123456"
#    password_confirmation "123456"
#  end
  factory :user do
    sequence(:first_name) { |n| "FirstName#{n}" }
    sequence(:last_name)  { |n| "LastName#{n}" }
    sequence(:username)   { |n| "username#{n}" }
    sequence(:email)      { |n| "email_#{n}@email.com" }
    password      "123456"
    password_confirmation "123456"
    
    factory :admin do
      admin true
    end
  end
end