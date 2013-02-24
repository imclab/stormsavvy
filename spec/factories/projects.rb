FactoryGirl.define do
  factory :project do
    user_id      1
    name        "Hwy 101 Corridor"
    description "Highway Improvements"
    startdate    DateTime.new(2011)
    finishdate   DateTime.new(2012)
    active       false

    # user

    factory :project_with_sites do
      ignore do
        sites_count 1
      end

      after(:create) do | project, evaluator|
        FactoryGirl.create_list(:site, evaluator.sites_count, project: project)
      end
    end
  end
end
