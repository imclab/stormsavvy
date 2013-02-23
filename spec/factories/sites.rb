FactoryGirl.define do
  factory :site do
    name          'Oakland Adams Point'
    address_1     '111 Adams Street'
    address_2     'Suite 181'
    description   'North of Lake Merritt'
    costcode      '450AZC'
    size          '20 acres'
    exposed_area  '10 acres'
    zipcode       94610
  end
end