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

User.create(name: 'Guest', email:'guest@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player')
User.create(name: 'DumbAI', email:'dumbai@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player')
User.create(name: 'KindAI', email:'midai@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player')
User.create(name: 'StrongAI', email:'strongai@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player')
User.create(name: 'Chae', email:'chae@email.example', password: 'password', created_at: Time.now, updated_at: Time.now, role: 'player')