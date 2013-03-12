# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u = User.create({name: 'test', password: 'test', password_confirmation: 'test'})
t = Team.create({name: 'Strangers', user_id: u.id})
p = Player.create([
   {name: 'Alice', team_id: t.id},
   {name: 'Bob', team_id: t.id},
   {name: 'Charlie', team_id: t.id},
   {name: 'Donna', team_id: t.id},
   {name: 'Erik', team_id: t.id},
   {name: 'Fiorella', team_id: t.id},
   {name: 'GOB', team_id: t.id},
   {name: 'Harold', team_id: t.id},
   {name: 'Inga', team_id: t.id},
   {name: 'Leo', team_id: t.id},
   {name: 'Mary', team_id: t.id},
   {name: 'Nancy', team_id: t.id},
   {name: 'Oscar', team_id: t.id},
   {name: 'Pam', team_id: t.id},
   {name: 'Quin', team_id: t.id},
   {name: 'Ricky', team_id: t.id},
   {name: 'Stacy', team_id: t.id},
   {name: 'Tilly', team_id: t.id},
   {name: 'Zack', team_id: t.id},
   {name: 'Virgina', team_id: t.id}
])
(1..10).each { |i|
  ActiveRecord::Base.transaction do
    g = Game.create({description: "Game #{i} - vs Someone", team_id: t.id})
    (1..25).each { |j|
      l = Line.create({received: rand(2), scored: rand(2), active: 0, game_id: g.id})
      p.shuffle.slice(1..7).each { |pl| l.players << pl }
    }
  end
}

u2 = User.create({name: 'test2', password: 'test', password_confirmation: 'test'})
t2 = Team.create({name: 'Other', user_id: u2.id})
