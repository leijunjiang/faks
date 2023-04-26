require 'algorithms'
require 'ostruct'

class Ranking
  def initialize
    @ranking_by_age = Hash.new{|k,v| k[v] = HeapMax.new}
  end

  def add(player)
    @ranking_by_age[player.age].add player
  end

  def champions
    @champions = rec_champions(@ranking_by_age.keys.min, @ranking_by_age.keys.max, -Float::INFINITY)
  end

  def rec_champions(begin_age, end_age, limit_score, champions = [])
    if begin_age > end_age
      return champions
    else
      if @ranking_by_age[begin_age] && @ranking_by_age[begin_age].max
        score, player_ids = @ranking_by_age[begin_age].max_score_with_array_of_players
        if score > limit_score
          champions += player_ids
          limit_score = score
        end
      end
      rec_champions(begin_age+=1, end_age, limit_score, champions)
    end
  end
end

class HeapMax
  def initialize
    @heap = Containers::MaxHeap.new
  end

  def add(player)
    @heap << [player.score, player.id] 
  end

  def max
    @heap.max
  end

  def max_score_with_array_of_players
    max_score, _ = @heap.max
    player_ids = []

    # trouver tous les joueurs avec le max score
    while !@heap.max.nil?
      score,  player_id = @heap.max
      if score == max_score
        score,  player_id =  @heap.pop
        player_ids << player_id
      else
        break
      end
    end

    # push back
    player_ids.each do |player_id|
      @heap << [max_score, player_id]
    end

    [max_score, player_ids]
  end
end

ranking = Ranking.new

player_1 = OpenStruct.new({id: 1, age: 12, score: 1000 })
player_2 = OpenStruct.new({id: 2, age: 13, score: 1100 })
player_3 = OpenStruct.new({id: 3, age: 16, score: 1600 })
player_4 = OpenStruct.new({id: 4, age: 17, score: 1600 })


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

player_5 = OpenStruct.new({id: 5, age: 12, score: 1050 })

ranking.add(player_5)
p ranking.champions
# => [5, 2, 3]
# player 5 (age 12) a un score supérieur par rapport au player 1, a un score inférieur  par rapport au player 3
# donc player 5 remplace le player 1

p ranking.champions
# => [5, 2, 3]
# le resultat ne change pas , d'où sans rajout d'effet de bord


player_6 = OpenStruct.new({id: 6, age: 18, score: 1850 })
player_7 = OpenStruct.new({id: 7, age: 18, score: 1850 })


ranking.add(player_6)
ranking.add(player_7)

p ranking.champions
# => [5, 2, 3, 7, 6]
# 6 et 7  ont le même âge

player_8 = OpenStruct.new({id: 8, age: 10, score: 2000 })
ranking.add(player_8)

p ranking.champions
# => [8]
# le player 8 élimine tout le monde, donc il devient le seul champion

player_9 = OpenStruct.new({id: 9, age: 15, score: 2000 })
ranking.add(player_9)

p ranking.champions
# => [8]


player_10 = OpenStruct.new({id: 10, age: 15, score: 25000 })
ranking.add(player_10)

p ranking.champions
# => [8, 10]


