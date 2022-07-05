Fabricator(:expense) do
  date { Faker::Date.backward(days: 1) }
  description { Faker::Lorem.word }
  user
  amount { Faker::Number.decimal(l_digits: 2) }
end