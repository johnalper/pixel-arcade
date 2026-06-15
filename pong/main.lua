WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
    -- set the window mode
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = false,
        vsync = true,
        fullscreen = false,
    })
end

function love.draw()
    -- print the message taking up full-width to center 
    love.graphics.printf('Hello, Pong!', 0, WINDOW_HEIGHT / 2 - 6, WINDOW_WIDTH, 'center')
end


