require 'gosu'

class RubyImage
  VISIBLE_TIME = 30
  INVISIBLE_LIMIT = -10
  START_VELOCITY = 4

  def initialize(x,y)
    @x = x
    @y = y
    @velocity_x = START_VELOCITY
    @velocity_y = START_VELOCITY
    @visible = 0
  end

  def draw
    image.draw(@x, @y, 1, factor, factor) if visible?
  end

  def show
    @visible = VISIBLE_TIME
  end

  def hide
    @visible = INVISIBLE_LIMIT
  end

  def update
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= -1 if @x + width > WhackARuby::WINDOW_WIDTH || @x < 0
    @velocity_y *= -1 if @y + height > WhackARuby::WINDOW_HEIGHT || @y < 0
    @visible -= 1
    @visible = VISIBLE_TIME if @visible < INVISIBLE_LIMIT && rand < 0.03
  end

  def width
    image.width * factor
  end

  def height
    image.height * factor
  end

  def x
    @image.height * factor
  end

  def x_middle
    @x + width / 2
  end

  def y_middle
    @y + height / 2
  end

  def factor
    0.08
  end

  def image
    @_image ||= Gosu::Image.new('images/ruby.png')
  end

  def visible?
    @visible > 0
  end

  def clicked_inside?(mouse_x,mouse_y)
    Gosu.distance(mouse_x, mouse_y, x_middle, y_middle) <= width
  end
end
