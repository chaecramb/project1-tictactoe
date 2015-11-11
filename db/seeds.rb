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

User.create(name: 'Guest', email:'guest@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player', desc: "Play against a guest on your own account")
User.create(name: 'Bender', email:'dumbai@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player', desc: "Bender's drunk and seems to be making moves at random")
User.create(name: 'Kryten', email:'kindai@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player', desc: "Kryten just wants to keep you happy. He tries to let you win all the time")
User.create(name: 'HAL 9000', email:'strongai@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player', desc: "I'm sorry Dave. I'm afraid i can't do that.")
User.create(name: 'R2-D2', email:'medai@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player', desc: "R2D2 likes a good game, so he'll give you a chance.")
User.create(name: 'Marvin', email:'neuroticai@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player', desc: "Marvin's paranoia make him an unpredictable opponent!")
User.create(name: 'Chae', email:'chae@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player')