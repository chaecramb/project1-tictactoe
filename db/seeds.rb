# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# g = Game.create(player1_id: 1, player2_id: 2, current_player_id: 2)

# g.moves << Move.create(player_id: 1, game_id: 1, square: 3) 
# g.moves << Move.create(player_id: 2, game_id: 1, square: 8) 
# g.moves << Move.create(player_id: 1, game_id: 1, square: 2) 
# g.moves << Move.create(player_id: 2, game_id: 1, square: 6) 
# g.moves << Move.create(player_id: 1, game_id: 1, square: 1) 

guest = User.create(name: 'Guest', email:'guest@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player', desc: "Play against a guest on your own account")
bender = User.create(name: 'Bender (AI)', email:'dumbai@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player', desc: "Bender's drunk and seems to be making moves at random")
kryten = User.create(name: 'Kryten (AI)', email:'kindai@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player', desc: "Kryten wants to keep you happy, he'll try to let you win")
hal = User.create(name: 'HAL 9000 (AI)', email:'strongai@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player', desc: "I'm sorry Dave. I'm afraid i can't do that.     ")
r2d2 = User.create(name: 'R2-D2 (AI)', email:'medai@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player', desc: "R2D2 likes a fair game, so he'll give you a chance.")
marvin = User.create(name: 'Marvin (AI)', email:'neuroticai@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player', desc: "His paranoia makes him an unpredictable opponent!")
spiderman = User.create(name: 'Spider-Man', email:'spiderman@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player', desc: "Your friendly neighbourhood Spider-Man.")
batman = User.create(name: 'Batman', email:'batman@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player', desc: "Bats frighten me. It’s time my enemies share my dread.")

guest.user_avatar = Rails.root.join("db/images/guest.jpg").open
guest.save
bender.user_avatar = Rails.root.join("db/images/bender.jpeg").open
bender.save
kryten.user_avatar = Rails.root.join("db/images/kryten.gif").open
kryten.save
hal.user_avatar = Rails.root.join("db/images/hal.png").open
hal.save
r2d2.user_avatar = Rails.root.join("db/images/r2d2.jpg").open
r2d2.save
marvin.user_avatar = Rails.root.join("db/images/marvin.jpg").open
marvin.save
spiderman.user_avatar = Rails.root.join("db/images/spiderman.jpg").open
spiderman.save
batman.user_avatar = Rails.root.join("db/images/batman.jpeg").open
batman.save

