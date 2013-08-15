# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sampling_event do
    site_id 1
    sampling_type "pH"
    sampling_description "ec jungle gym sampling"
    sampling_date "2013-01-27 15:34:07"
    submitted_by "wyu"
    sampled_by "wyu"
    sample_id_1 1
    sample_location_1 "jungle gym"
    sample_time_1 "2013-01-27 15:34:07"
    analysis_type_1 "pH"
    analysis_result_1 "7.00"
    analysis_average_1 "7.01"
    sample_id_2 1
    sample_location_2 "playground slide"
    sample_time_2 "2013-01-27 15:34:07"
    analysis_type_2 "pH"
    analysis_result_2 "7.10"
    analysis_average_2 "7.01"
    sample_id_3 1
    sample_location_3 "playground seesaw"
    sample_time_3 "2013-01-27 15:34:07"
    analysis_type_3 "pH"
    analysis_result_3 "6.90"
    analysis_average_3 "7.01"
    sample_id_4 1
    sample_location_4 "merry go round"
    sample_time_4 "2013-01-27 15:34:07"
    analysis_type_4 "pH"
    analysis_result_4 "6.95"
    analysis_average_4 "7.01"
    sample_id_5 1
    sample_location_5 "playground swings"
    sample_time_5 "2013-01-27 15:34:07"
    analysis_type_5 "pH"
    analysis_result_5 "7.20"
    analysis_average_5 "7.01"
    completed false
  end

  factory :sampling_event_attachment do
    item File.new("#{Rails.root}/app/assets/pdfs/CEM2030_production_v1.pdf") 
  end
end
