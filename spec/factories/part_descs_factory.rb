require 'faker'

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :part_desc do
    desc     { Faker::Lorem.sentence }
    manufac  { Faker::Lorem.characters(rand(15)+2) }
    parttype { Faker::Lorem.characters(rand(5)+8) }
    partno   { Faker::Lorem.characters(rand(4)+6) }
    factory :invalid_part_desc_desc do
      desc nil
    end
    factory :invalid_part_desc_manufac do
      manufac nil
    end
    factory :invalid_part_desc_parttype do
      parttype nil
    end
  end
end
