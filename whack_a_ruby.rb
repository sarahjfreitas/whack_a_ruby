require 'gosu'
require './ruby_image.rb'

class WhackARuby < Gosu::Window
  WINDOW_WIDTH = 800
  WINDOW_HEIGHT = 600

  def initialize
    super(WINDOW_WIDTH,WINDOW_HEIGHT)
    self.caption = 'Whack the Ruby!'

    @ruby_image = RubyImage.new(200,200)
    @hammer_image = Gosu::Image.new('images/hammer.png')
    @font = Gosu::Font.new(30)
    @score = 0
    @playing = true
    @start_time = 0
    @screen_color = Gosu::Color::NONE
  end

  def update
    return unless @playing

    @ruby_image.update
    @playing = false if time_left <= 0
  end

  def draw
    if @playing
      @hammer_image.draw(mouse_x - @hammer_image.width * 0.1 / 2, mouse_y - @hammer_image.height / 2 * 0.1, 1,0.1,0.1)
      @font.draw_text("Time left: #{time_left}", 20,20,2)
      @font.draw_text("Score: #{@score}", 600,20,2)

      draw_quad(
        0,0,@screen_color, #vertice 1
        WINDOW_WIDTH,0,@screen_color, #vertice 2
        WINDOW_WIDTH,WINDOW_HEIGHT,@screen_color, #vertice 3
        0,WINDOW_HEIGHT,@screen_color #vertice 4
      )
      @screen_color = Gosu::Color::NONE
    else
      @font.draw_text("Game Over! You got #{@score} points.",200,300, 3)
      @font.draw_text("Press the Space Bar to Play Again.",200,400, 3)
      @ruby_image.show
    end

    @ruby_image.draw
  end

  def button_down(id)
    if id == Gosu::MsLeft
      return unless @playing

      if @ruby_image.visible? && @ruby_image.clicked_inside?(mouse_x,mouse_y)
        @screen_color = Gosu::Color::GREEN
        @score += 5
      else
        @screen_color = Gosu::Color::RED
        @score -= 2
      end
    elsif id == Gosu::KbSpace
      restart unless @playing
    end
  end

  private

  def time_left
    30 - ((Gosu.milliseconds - @start_time) / 1000)
  end

  def restart
    @playing = true
    @start_time = Gosu.milliseconds
    @score = 0
    @ruby_image.hide
  end
end

window = WhackARuby.new
window.show
