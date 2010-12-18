require 'rubygems'
require 'gosu'
require 'player'
require 'ufo'

class GameWindow < Gosu::Window
  
  def initialize
    super(1000, 1000 , false)
    self.caption = "UFOs Game"
    @background_image = Gosu::Image.new(self, "images/starry_night.png", true)
    @player1 = Player.new(self, 500, 600, 0, "images/player_1.png")
    @player2 = Player.new(self, 200, 600, 0, "images/player_2.png")
    @score_font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @message_font = Gosu::Font.new(self, Gosu::default_font_name, 60)
    start_game
  end
   
  def start_game
    @ufos = Ufo.create_many(self, 6)
    @playing = true
    @players = [@player1, @player2]
    @player1.score = 0
    @player2.score = 0
  end
  
  def draw
    @background_image.draw(0, 0, 1)
    @player2.draw
    @player1.draw
    @ufos.each {|ufo| ufo.draw(@players)}
    @score_font.draw("Player 1: #{@player1.score}", 10, 150, 4, 1.0, 1.0, 0xffffff00)
    @score_font.draw("Player 2: #{@player2.score}", 10, 180, 4, 1.0, 1.0, 0xffffff00)
    if(@ufos.size == 0)
      @playing = false
      message("It is a tie!") if @player1.score == @player2.score
      message("Player 1 is the winner !") if @player1.score > @player2.score
      message("Player 2 is the winner !") if @player2.score > @player1.score
    end
  end
  
  def message (message)
    @message_font.draw(message, 300, 300, 4, 1.0, 1.0, 0xffffff00)
  end
  
  def update
    if button_down? Gosu::Button::KbLeft and @playing
      @player1.move_horizontal(-1)
    end
    
    if button_down? Gosu::Button::KbRight and @playing
     @player1.move_horizontal(+1)
    end
    
    if button_down? Gosu::Button::KbLeftAlt and @playing
      @player2.move_horizontal(+1)
    end
    
    if button_down? Gosu::Button::KbLeftControl and @playing
      @player2.move_horizontal(-1)
    end
    
    if button_down? Gosu::Button::KbLeftShift and @playing
      @player2.shoot(-1)
    end
    
    if button_down? Gosu::Button::KbRightShift and @playing
      @player1.shoot(-1)
    end
    
    unless button_down? Gosu::Button::KbLeftShift and @playing
      @player2.reset_shooter
    end
    
    unless button_down? Gosu::Button::KbRightShift and @playing
      @player1.reset_shooter
    end
    
    if button_down? Gosu::Button::KbEscape and @playing == false
      start_game
    end
    
  end
  
end

window = GameWindow.new

window.show