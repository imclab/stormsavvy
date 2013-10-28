FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@stormsavvy.com" }
    password "passwood"
    password_confirmation "passwood"
    # remember_me :true

    factory :user_with_sites do
      sequence(:email) { |n| "email#{n}@stormsavvy.com" }

      ignore do
        projects_count 1
        ignore do
          sites_count 2
        end
      end

      after(:create) do | user, evaluator|
        FactoryGirl.create_list(:project, evaluator.projects_count, user: user)
      end
    end
  end
end
