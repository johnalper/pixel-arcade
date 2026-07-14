push = require 'push'
Class = require 'class'

require 'Paddle'

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

    smallFont = love.graphics.newFont('font.ttf', 8)     -- define small font
    largeFont = love.graphics.newFont('font.ttf', 32)    -- define large font

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = false,
        vsync = true,
        fullscreen = false,
    })

    -- virtual layer upscales and then shrinks to fit the application window
    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = 'normal' })

    -- setup paddles/players
    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    player1Score = 0
    player2Score = 0

    -- ball velocity and position
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    -- coin-flip decides the side to shoot the ball
    ballDX = math.random(2) == 1 and 100 or -100
    -- randomly choose the ball trejactory
    ballDY = math.random(-50, 50)

    -- defines the game states
    gameState = 'start'
end

function love.keypressed(key)
    -- exit app on Esc key
    if key == 'escape' then
        love.event.quit()
    -- hit enter to play or reset game state
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            -- set ball in the middle
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2

            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50) * 1.5
        end
    end
end

function love.update(dt)
    -- player 1 (left) paddle movement
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- player 2 (right) paddle movement
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    -- update game state and ball state
    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end

    player1:update(dt)
    player2:update(dt)
end

function love.draw()
    -- start the magnification / virtual resolution
    push.start() 

    -- dividing since floating point values expected
    love.graphics.clear(40/255, 45/255, 52/255, 1) 
    love.graphics.setFont(largeFont)

    if gameState == 'start' then
        love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    --print score (disabled since testing game states)
    --love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 2 - 80)
    --love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 2 - 80)

    --render paddles
    player1:render()
    player2:render()

    -- ball
    love.graphics.rectangle('fill', ballX, ballY, 4, 4)

    -- end the magnification / virtual resolution
    push.finish() 
end

