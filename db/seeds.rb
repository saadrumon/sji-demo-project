# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(name: 'Mobile Client', redirect_uri: '', scopes: '')
end

user = User.find_or_initialize_by(email: 'super_admin@nascenia.com')

unless user.persisted?
  user.first_name = 'Admin'
  user.last_name = 'User'
  user.password = '123456'
  user.password_confirmation = '123456'
  user.is_admin = true
  user.save!
end
