push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual window size
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest') -- bilinear filtering

    -- seed the RNG with the current time
    math.randomseed(os.time())

    largeFont = love.graphics.newFont('font.ttf', 32)    -- define large font
    smallFont = love.graphics.newFont('font.ttf', 8)     -- define small font

    player1Score = 0
    player2Score = 0

    -- ball velocity and position
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    -- coin-flip ternary decides the left or right start
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = false,
        vsync = true,
        fullscreen = false,
    })

    -- virtual layer upscales and then shrinks to fit the application window
    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = 'normal' })
end

function love.keypressed(key)
    -- exit app on Esc key
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    -- left paddle movement
    if love.keyboard.isDown('w') then
        -- math.max for top collusion detection 
        -- calculate paddle speed scaled by delta time
        player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        -- math.min for bottom collusion detection 
        -- calculate paddle speed scaled by delta time
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end

    -- right paddle movement
    if love.keyboard.isDown('up') then
        -- calculate top collusion and speed scaled by delta time
        player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        -- calculate bottom collusion and speed scaled by delta time
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end

    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end

function love.draw()
    push.start() -- start the magnification
    -- dividing since floating point values expected
    love.graphics.clear(40/255, 45/255, 52/255, 1) 
    love.graphics.setFont(largeFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 2 - 80)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 2 - 80)

    -- paddle one
    love.graphics.rectangle('fill', 10, player1Y, 5, 20) 
    -- paddle two
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 15, player2Y, 5, 20) 
    -- ball
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    push.finish() -- end the magnification
end

