# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Game.create([{gtype: "Website Go", quantity: 5, code: 46}, {gtype: "Sponsors Go", quantity: 5, code: 39}, {gtype: "Summit Go", quantity: 4, code: 89}, {gtype: "CIO Members Go", quantity: 16, code: 76}])
Question.create([{code: 183, number: 1, answer: 2, game_id: 1}, {code: 204, number: 2, answer: 1, game_id: 1}, {code: 673, number: 3, answer: 3, game_id: 1}, {code: 430, number: 4, answer: 1, game_id: 1}, {code: 996, number: 5, answer: 3, game_id: 1}, {code: 823, number: 1, answer: 1, game_id: 2}, {code: 780, number: 2, answer: 3, game_id: 2}, {code: 695, number: 3, answer: 2, game_id: 2}, {code: 257, number: 4, answer: 3, game_id: 2}, {code: 683, number: 5, answer: 1, game_id: 2}, {code: 294, number: 1, answer: 1, game_id: 3}, {code: 879, number: 2, answer: 2, game_id: 3}, {code: 611, number: 3, answer: 3, game_id: 3}, {code: 432, number: 4, answer: 2, game_id: 3}, {code: 953, number: 1, answer: 1, game_id: 4}, {code: 706, number: 2, answer: 2, game_id: 4}, {code: 475, number: 3, answer: 3, game_id: 4}, {code: 289, number: 4, answer: 2, game_id: 4}, {code: 752, number: 5, answer: 3, game_id: 4}, {code: 388, number: 6, answer: 2, game_id: 4}, {code: 876, number: 7, answer: 2, game_id: 4}, {code: 197, number: 8, answer: 1, game_id: 4}, {code: 541, number: 9, answer: 3, game_id: 4}, {code: 390, number: 10, answer: 1, game_id: 4}, {code: 336, number: 11, answer: 2, game_id: 4}, {code: 265, number: 12, answer: 1, game_id: 4}, {code: 419, number: 13, answer: 1, game_id: 4}, {code: 522, number: 14, answer: 3, game_id: 4}, {code: 283, number: 15, answer: 2, game_id: 4}, {code: 370, number: 16, answer: 3, game_id: 4}])
User.create(email: "a@a.com", password: "123456", password_confirmation: "123456")