FactoryBot.define do
  factory :traceable_contract do
    premium { 2000 }
    activated_at { Time.current }
  end
end
