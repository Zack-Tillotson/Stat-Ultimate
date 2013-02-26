# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
t = Team.create({name: 'oneone'})
p = Player.create([
    {name: 'alice', team_id: t.id},
   {name: 'bob', team_id: t.id},
   {name: 'charlie', team_id: t.id},
   {name: 'delta', team_id: t.id},
   {name: 'echo', team_id: t.id},
   {name: 'foxtrot', team_id: t.id},
   {name: 'global', team_id: t.id},
   {name: 'harry', team_id: t.id},
   {name: 'incontrol', team_id: t.id},
   {name: 'lemon', team_id: t.id},
   {name: 'mortimer', team_id: t.id},
   {name: 'nifty', team_id: t.id},
   {name: 'oscar', team_id: t.id},
   {name: 'prego', team_id: t.id},
   {name: 'quickly', team_id: t.id},
   {name: 'ricky', team_id: t.id},
   {name: 'stacy', team_id: t.id},
   {name: 'tilly', team_id: t.id},
   {name: 'under', team_id: t.id},
   {name: 'vergo', team_id: t.id}
])
(1..10).each { |i|
  ActiveRecord::Base.transaction do
    g = Game.create({description: "Game #{i}", team_id: t.id})
    (1..25).each { |j|
      l = Line.create({scored: rand(2), active: 0, game_id: g.id})
      p.shuffle.slice(1..7).each { |pl| l.players << pl }
    }
  end
}
