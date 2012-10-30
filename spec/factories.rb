FactoryGirl.define do
  factory :user do
    first_name    "Pierre"
    last_name     "Lasante"
    username      "plasante"
    email         "plasante@email.com"
    password      "123456"
    password_confirmation "123456"
  end
end