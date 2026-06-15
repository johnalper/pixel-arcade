push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual window size
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest') -- bilinear filtering

    largeFont = love.graphics.newFont('font.ttf', 32)    -- define large font
    smallFont = love.graphics.newFont('font.ttf', 8)     -- define small font

    player1Score = 0
    player2Score = 0

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

function love.draw()
    push.start() -- start the magnification
    -- dividing since floating point values expected
    love.graphics.clear(40/255, 45/255, 52/255, 1) 
    love.graphics.setFont(largeFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 2 - 80)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 2 - 80)

    -- paddle one
    love.graphics.rectangle('fill', 10, 10, 5, 20) 
    -- paddle two
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 30, 5, 20) 
    -- ball
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    push.finish() -- end the magnification
end

