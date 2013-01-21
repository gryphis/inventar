require 'faker'

FactoryGirl.define do
  factory :part do
    desc     { Faker::Lorem.sentence }
    serial   { Faker::Lorem.characters(rand(15)+6) }
    price    { price_up_to_9990000 }
    datev_id { "%d" % (rand(900000)+100000) }

    factory :invalid_desc do
      desc nil
    end

    factory :invalid_price do
      price { -price_up_to_9990000 }
    end
  end
end

private
def price_up_to_9990000
  (rand(1000)*10**rand(7))/100.0
end
