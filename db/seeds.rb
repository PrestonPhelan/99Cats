# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  { user_name: "Panda", password: "pandas" }
  ])

Cat.create([
  { name: "Cheeto", color: "orange", sex: "M", birth_date: "15/12/2010", user_id: 1 },
  { name: "Rick", color: "white", sex: "M", birth_date: "04/04/2008", description: "Wubba lub a dub dub", user_id: 1 }
  ])
