# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inspection_event do
    site_id 1
    inspection_type "weekly"
    inspection_description "ec jungle gym inspection"
    inspection_date "2013-01-26 23:13:55"
    submitted_by "wyu"
    inspected_by "wyu"
  end

  factory :attachment do
    item File.new("#{Rails.root}/app/assets/pdfs/CEM2030_production_v1.pdf") 
  end
end
