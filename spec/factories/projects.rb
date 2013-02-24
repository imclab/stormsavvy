FactoryGirl.define do
  factory :project do
    user_id      1
    name        "Hwy 101 Corridor"
    description "Highway Improvements"
    startdate    DateTime.new(2011)
    finishdate   DateTime.new(2012)
    active       false

    factory :project_with_site do
      after_create do |site|
        create(:site, project: project)
      end
    end
    
  end
end
