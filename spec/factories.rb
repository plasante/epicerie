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
  
  factory :micropost do
    content "Lorem ipsum"
    # we tell Factory Girl about the micropost's associated user
    user
  end

  factory :magasin_type do
    sequence(:nom) { |n| "grocery#{n}" }
  end

  factory :magasin do
    sequence(:nom) { |n| "magasin#{n}" }
    sequence(:description) { |n| "description#{n}" }
    magasin_type
  end

  factory :produit_nom do
    sequence(:nom) { |n| "nom#{n}" }
  end

  factory :category do
    sequence(:nom) { |n| "nom#{n}" }
  end

  factory :fabricant do
    sequence(:nom) { |n| "nom#{n}" }
  end

  factory :format do
    sequence(:nom) { |n| "nom#{n}" }
  end

  factory :produit do
    produit_nom
    category
    fabricant
    format
    description "description"
  end
end