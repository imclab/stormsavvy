FactoryGirl.define do
  factory :site do
    name          'Oakland Adams Point'
    address_1     '111 Adams Street'
    address_2     'Suite 181'
    city          'Oakland'
    state         'CA'
    zipcode       94610

    description   'North of Lake Merritt'
    costcode      '450AZC'
    size          '20 acres'
    exposed_area  '10 acres'

    project
  end
end