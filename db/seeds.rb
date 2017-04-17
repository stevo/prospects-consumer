# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



bruce = User.create(first_name: "Bruce", last_name: "Willis" , email: "brucey@example.dev", admin: true)

tony = bruce.prospects.create(name: "Iron Man", target: true)
taiga = bruce.prospects.create(name: "Taiga Aisaka", target: true)

tony.documents.create(
  title: "CV Dariusz Whylon",
  body: "Ultimate CV contents",
  creator: bruce,
  document_type: :cv,
  meta: { experience: "10" },
  created_at: Date.current
)
tony.documents.create(
  title: "CV Radoslav Beu",
  body: "Fabricates exquisite beer",
  creator: bruce,
  document_type: :cv,
  meta: { experience: "5" },
  created_at: Date.current
)
taiga.documents.create(
  title: "CV Arkadius Sour",
  body: "Used to have longer hair",
  creator: bruce,
  document_type: :cv,
  meta: { experience: "15" },
  created_at: Date.current - 2.days
)
tony.documents.create(
  title: "CV Radoslav Beu",
  body: "Those guys are great!",
  creator: bruce,
  document_type: :team_presentation,
  meta: { experience: "5" },
  created_at: Date.current - 5.days
)



