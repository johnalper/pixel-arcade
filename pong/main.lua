push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual window size
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
    -- set filter to be point graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- set the window mode
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
    -- starts the magnification
    push.start()
    
    -- print using virtual window width/height terms
    love.graphics.printf('Hello, Pong!', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')

    -- end magnification
    push.finish()
end

