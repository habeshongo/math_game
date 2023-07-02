class Player
    attr_reader :score, :lives
  
    def initialize(score = 0, lives = 3)
      @score = score
      @lives = lives
    end
  
    def reduce_life
      @lives -= 1
    end
  
    def update_score(points)
      @score += points
    end
  end
  