FactoryGirl.define do
  factory :user do
    firstname "Walter"
    lastname "Yu"
    email "walter@stormsavvy.com"
    password "DarkAndStormy"
    password_confirmation "DarkAndStormy"
    remember_me :true
  end
end