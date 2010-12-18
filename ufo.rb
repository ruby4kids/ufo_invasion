class Ufo
  
  @@ufos = []
  
  def initialize(window, offset=0)
    @ufo_image = Gosu::Image.new(window, "images/ufo.png", false)
    @explosion_image = Gosu::Image.new(window, "images/explosion.png", false)
    @boom = Gosu::Sample.new(window, "sounds/explosion.wav")
    @x = offset
    @y = 0
    @right_edge = window.width
    @left_edge = 0
  end
  
  def draw(players)
    ufo_dead = false
    players.each do |player|
      if self.hit_by? player
        player.score += 10
        ufo_dead = true
        break
      end
    end
    
    if ufo_dead
      @boom.play
      @explosion_image.draw(@x, @y, 2)
      @@ufos.delete self
    else
      @x += 5
      @x = @right_edge if @x < @left_edge
      @x = @left_edge if @x > @right_edge
      @ufo_image.draw(@x, @y, 2)
    end
    
    
  end
  
  def hit_by? (player)
    Gosu::distance(@x, @y, player.bullet_x, player.bullet_y) < 40
  end
  
  def self.create_many(window, how_many)
    spacing = window.width / how_many
    offset = 0
    how_many.times do
      @@ufos << self.new(window, offset)
      offset += spacing
    end
    @@ufos
  end
  
end
