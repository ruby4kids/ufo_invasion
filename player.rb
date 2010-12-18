
class Player
  attr_reader :x, :y, :bullet_x, :bullet_y
  attr_accessor :dead, :score
  
  def initialize(window, x, y, angle, picture)
    @player_image = Gosu::Image.new(window, picture, false)
    @x = x
    @y = y
    @angle = angle
    @left_edge = 0
    @right_edge = window.width
    @bullet_image = Gosu::Image.new(window, "images/bullet.png", true)
    @bullet_sound = Gosu::Sample.new(window, "sounds/shoot.wav")
    @bullet_y = @y
    @bullet_x = @x
    @bullet_order = 0
    @dead = false
    @score = 0
  end
  
  def draw
    @player_image.draw_rot(@x, @y, 2, @angle)
    @bullet_image.draw(@bullet_x, @bullet_y, @bullet_order)
  end
  
  def move_horizontal(direction)
    @x += (direction * 10)
    @x = @right_edge if @x < @left_edge
    @x = @left_edge if @x > @right_edge
  end
  
  def shoot(direction)
    @bullet_order = 1
    @bullet_y += 100 * direction
    @bullet_sound.play
  end
  
  def reset_shooter
    @bullet_y = @y
    @bullet_x = @x
    @bullet_order = 0
  end
  
end



