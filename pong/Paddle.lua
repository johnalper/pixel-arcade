Paddle = Class{}

function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
end

function Paddle:update(dt)
    if self.dy < 0 then
        -- math.max for top collusion detection 
        -- calculate top collusion and speed scaled by delta time
        self.y = math.max(0, self.y + self.dy * dt)
    else
        -- math.min for bottom collusion detection 
        -- calculate bottom collusion and speed scaled by delta time
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end
end

function Paddle:render()
    -- draw paddles
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
