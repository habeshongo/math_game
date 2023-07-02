require_relative 'player'
require_relative 'math_question'

class Game
  def initialize(player1, player2)
    @players = [player1, player2]
    @current_player = player1
  end

  def start
    loop do
      puts "----- NEW TURN -----"
      question = MathQuestion.generate
      puts "#{current_player.name}: #{question}"
      answer = gets.chomp.to_i

      if validate_answer(answer, question)
        puts "Correct answer!"
        current_player.update_score(1)
      else
        puts "Incorrect answer!"
        current_player.reduce_life
      end

      announce_scores

      break if game_over?

      change_turn
    end

    announce_result
  end

  private

  attr_reader :players
  attr_accessor :current_player

  def validate_answer(answer, question)
    answer == question.sum
  end

  def change_turn
    @current_player = (@current_player == players[0] ? players[1] : players[0])
  end

  def announce_scores
    players.each do |player|
      puts "#{player.name} Score: #{player.score}, Lives: #{player.lives}"
    end
  end

  def game_over?
    players.any? { |player| player.lives.zero? }
  end

  def announce_result
    puts "----- GAME OVER -----"
    winner = players.find { |player| player.lives > 0 }
    loser = players.find { |player| player.lives.zero? }
    puts "#{winner.name} wins with a score of #{winner.score}"
    puts "#{loser.name} final score: #{loser.score}"
  end
end
