require 'faker'
require 'uri'

ActionMailer::Base.perform_deliveries = false

user = FactoryBot.create(:user, email: 'test@test.com', password: '123456')
user.confirm

puts "-> User created with email #{user.email} and password #{user.password}"

20.times do
  FactoryBot.create(:pet, user: user)
end

puts "-> #{Pet.count} pets created"
