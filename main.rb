class Ranking
  def initialize
    @players = []
  end

  def add(player)
    @players << player
  end

  def champions
    @champions = find_champions
  end

  def find_champions
    @players.sort_by! { |player| [-player[:score], player[:age]] }
    champions = []
    min_age = Float::INFINITY
    limit_score = nil

    @players.each do |player|
      if player[:age] < min_age
        champions << player[:id]
        min_age = player[:age]
        limit_score = player[:score]
      elsif player[:age] == min_age && player[:score] == limit_score
        champions << player[:id]
      end
    end

    champions
  end
end

ranking = Ranking.new

player_1 = {id: 1, age: 12, score: 1000 }
player_2 = {id: 2, age: 13, score: 1100 }
player_3 = {id: 3, age: 16, score: 1600 }
player_4 = {id: 4, age: 17, score: 1600 }


ranking.add(player_1)
ranking.add(player_2)
ranking.add(player_3)
ranking.add(player_4)

p ranking.champions
# => [1, 2, 3]
# player 1 est le meilleur de sa catégorie age: 12
# player 2 est le meilleur de sa catégorie age: 13
# player 3 est le meilleur de sa catégorie age: 16
# player 4 est le meilleur de sa catégorie age: 17, cependant il est moins fort que le player 3

player_5 = {id: 5, age: 12, score: 1050 }

ranking.add(player_5)
p ranking.champions
# => [5, 2, 3]
# player 5 (age 12) a un score supérieur par rapport au player 1, a un score inférieur  par rapport au player 3
# donc player 5 remplace le player 1

p ranking.champions
# => [5, 2, 3]
# le resultat ne change pas , d'où sans rajout d'effet de bord


player_6 = {id: 6, age: 18, score: 1850 }
player_7 = {id: 7, age: 18, score: 1850 }


ranking.add(player_6)
ranking.add(player_7)

p ranking.champions
# => [5, 2, 3, 7, 6]
# 6 et 7  ont le même âge

player_8 = {id: 8, age: 10, score: 2000 }
ranking.add(player_8)

p ranking.champions
# => [8]
# le player 8 élimine tout le monde, donc il devient le seul champion

player_9 = {id: 9, age: 15, score: 2000 }
ranking.add(player_9)

p ranking.champions
# => [8]


player_10 = {id: 10, age: 15, score: 25000 }
ranking.add(player_10)

p ranking.champions
# => [8, 10]


players_list = [
  { id: 'A', age: 25, score: 2000 },
  { id: 'B', age: 30, score: 2200 },
  { id: 'C', age: 22, score: 1800 },
  { id: 'D', age: 28, score: 2300 },
  { id: 'E', age: 20, score: 1900 },
  { id: 'F', age: 33, score: 2100 }
]

ranking2 = Ranking.new
players_list.each do |player|
  ranking2.add player
end

p ranking2.champions
# => ["D", "A", "E"]
