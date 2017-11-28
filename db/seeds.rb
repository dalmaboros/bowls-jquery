# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Bowl.create(name: "Chill", description: "Things to do when I have a minute")
Bowl.create(name: "Hype", description: "Break a sweat")
Bowl.create(name: "Expression", description: "Process over product")

Scrap.create(description: "Sonic Pi", category: "music", bowl_ids: 1)
Scrap.create(description: "Skateboard", category: "exercise", bowl_ids: 2)
Scrap.create(description: "Draw", category: "art", bowl_ids: 3)
