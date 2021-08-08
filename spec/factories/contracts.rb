FactoryBot.define do
  factory :contract do
    customer
    traceable_contracts { build_list :traceable_contract, 1 }
  end
end
