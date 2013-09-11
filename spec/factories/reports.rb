FactoryGirl.define do
  factory :report do
    site_id 1
  	status "Active"
  end

  factory :attachment do
    item File.new("#{Rails.root}/app/assets/pdfs/CEM2030_production_v1.pdf") 
  end
end
