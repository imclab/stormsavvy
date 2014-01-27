FactoryGirl.define do
  factory :site do
    sequence(:name) { |n| "project_name#{n}" }
    # name 'Oakland Adams Point'
    address_1 '111 Adams Street'
    address_2 'Suite 181'
    city 'Oakland'
    state 'CA'
    zipcode 94610

    description 'North of Lake Merritt'
    costcode '450AZC'
    size '20 acres'
    exposed_area '10 acres'

    lat 38.2473117
    long 122.5712101

    project_ea '3A23U4'
    wdid_number '004001005'
    construction_phase 'active'

    contractor_name 'gcc'
    contractor_address_1 'gcc hq'
    contractor_address_2 '246 gcc ave'
    contractor_city 'santa rosa'
    contractor_state 'CA'
    contractor_zipcode '95407'
    contract_number '154009'

    wpcm_name 'yoda'
    wpcm_company 'gcc'
    wpcm_phone '707-555-9999'
    wpcm_emergency_phone '707-555-9999'
    qsp_name 'obi'
    qsp_company 'gcc'
    qsp_phone '707-555-9999'
    qsp_emergency_phone '707-555-9999'

    total_area 50.00
    total_dsa 30.00
    current_dsa 20.00
    inactive_dsa 10.00

    time_since_last_storm '99 days'
    precipitation_received 0.50

    permits '401/1601'
    resident_engineer_name 'yogi'
    structures_representative_name 'barney'

    str = "Mon, 27 Jan 2014"
    date = Date.parse str
    last_bmp_status date
    last_inspection "Mon, 27 Jan 2014"
    last_corrective_action "Mon, 27 Jan 2014"
    last_reap "Mon, 27 Jan 2014"
    last_training "Mon, 27 Jan 2014"
    last_weather_forecast "Mon, 27 Jan 2014"
    last_sampling "Mon, 27 Jan 2014"
  end
end
