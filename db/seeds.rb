require 'faker'
require 'uri'

ActionMailer::Base.perform_deliveries = false

user = FactoryBot.create(:user, email: 'test@test.com', password: '123456')
user.confirm

puts "-> User created with email #{user.email} and password #{user.password}"

10.times do
  pet = FactoryBot.create(:pet, user: user)
  picture = URI.open(Faker::Avatar.image)
  pet.pictures.attach(io: picture, filename: File.basename(picture.path))
end

puts "-> #{Pet.count} pets created"
