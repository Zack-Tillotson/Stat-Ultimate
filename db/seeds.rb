# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
t = Team.create([{name: 'oneone'}])
p = Player.create([
    {name: 'alice', team_id: t.first.id},
   {name: 'bob', team_id: t.first.id},
   {name: 'charlie', team_id: t.first.id},
   {name: 'delta', team_id: t.first.id},
   {name: 'echo', team_id: t.first.id},
   {name: 'foxtrot', team_id: t.first.id},
   {name: 'global', team_id: t.first.id},
   {name: 'harry', team_id: t.first.id},
   {name: 'incontrol', team_id: t.first.id},
   {name: 'lemon', team_id: t.first.id},
   {name: 'mortimer', team_id: t.first.id},
   {name: 'nifty', team_id: t.first.id},
   {name: 'oscar', team_id: t.first.id},
   {name: 'prego', team_id: t.first.id},
   {name: 'quickly', team_id: t.first.id},
   {name: 'ricky', team_id: t.first.id},
   {name: 'stacy', team_id: t.first.id},
   {name: 'tilly', team_id: t.first.id},
   {name: 'under', team_id: t.first.id},
   {name: 'vergo', team_id: t.first.id}
])
g = Game.create([{description: 'game 1 vs other team', active: true, team_id: t.first.id}])
l = Line.create([{scored: 0, active: 1, game_id: g.first.id}])
Player.all.each { |pl| l.first.players << pl }
