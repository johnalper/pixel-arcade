Ball = Class{}

function Ball:init(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height

  -- coin-flip decides the side to shoot the ball
  self.dy = math.random(2) == 1 and -100 or 100
  -- randomly choose the ball trejactory
  self.dx = math.random(-50, 50)
end
