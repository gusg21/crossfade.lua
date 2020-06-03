-- Driver for the crossfade library

Crossfade = require("crossfade")

function love.load()
    Crossfade:load("music/Track 1.mp3")
    Crossfade:silence()
    Crossfade:fadeIn()
    Crossfade:play()
end

function love.keypressed(key, scancode, isRepeat)
    if key == "space" then
        Crossfade:crossfade("music/Track 2.mp3")
    end
end

function love.update(dt)
    Crossfade:update()
end