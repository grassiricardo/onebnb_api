FactoryGirl.define do
  factory :property do
    price "9.99"
    name "MyString"
    description "MyText"
    user nil
    accommodation_type 1
    guest_max 1
    beds 1
    bedroom 1
    address nil
    status 1
    facility nil
    bathroom 1
  end
end
