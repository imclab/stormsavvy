FactoryGirl.define do
  factory :user do
    firstname "Walter"
    lastname "Yu"
    email "walter@stormsavvy.com"
    password "DarkAndStormy"
    password_confirmation "DarkAndStormy"
    remember_me :true

    factory :user_with_projects do
      ignore do
        projects_count 1
      end

      after(:create) do | user, evaluator|
        FactoryGirl.create_list(:project, evaluator.projects_count, user: user)
      end
    end
  end
end