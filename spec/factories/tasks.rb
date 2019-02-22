FactoryBot.define do
  factory :task do
    name {'test task'}
    description {'prepare something for dinner'}
    user
  end
end