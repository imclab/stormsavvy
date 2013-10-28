FactoryGirl.define do
  sequence :email do |n|
    'email#{n}@stormsavvy.com'
  end

  factory :user do
    firstname "Walter"
    lastname "Yu"
    email
    password "passwood"
    password_confirmation "passwood"
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
