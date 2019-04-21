# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'nico@email.com', password: 'password',
            first_name: 'Nicolas', last_name: 'Firavitoba')
categories = %w[Home Work Personal Friends Study Appointments]
categories.each { |category| Category.create(name: category) }
10.times { |i| List.create(name: "My list #{i + 1}", user_id: 1, category_id: rand(1..5)) }
10.times { |i| Task.create(body: "Task for testing No. #{i}", list_id: 1) }
