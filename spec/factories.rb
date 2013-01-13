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
    magasin_type
  end

  factory :category do
    sequence(:nom) { |n| "category#{n}" }
  end

  factory :manufacturer do
    sequence(:nom) { |n| "manufacturer#{n}" }
  end

  factory :produit do
    sequence(:nom) { |n| "produit#{n}" }
    sequence(:description) { |n| "description#{n}" }
    category
    manufacturer
  end

  factory :magasin_produit do
    quantity 1
    prix_requlier 1.5
    prix_special 1.0
    magasin
    produit
  end
end