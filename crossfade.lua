-- Crossfade is a simple LOVE2D music library

Crossfade = {}

Crossfade.sourceType = "stream" -- usually you don't want to change this, but you can

Crossfade.loadedSources = {}
Crossfade.currentSource = nil
Crossfade.tempSource = nil

Crossfade.targetVolume = 1
Crossfade.fadeSpeed = 0.01

Crossfade.play = function (self)
    -- print(track)

    self.currentSource:play()
end

Crossfade.load = function (self, track)
    if (self.loadedSources[track] == nil) then
        self.loadedSources[track] = love.audio.newSource(track, self.sourceType)
    end

    self.currentSource = self.loadedSources[track]
end

Crossfade.loadToTemp = function (self, track)
    if (self.loadedSources[track] == nil) then
        self.loadedSources[track] = love.audio.newSource(track, self.sourceType)
    end

    self.tempSource = self.loadedSources[track]
end

Crossfade.silence = function (self)
    self.currentSource:setVolume(0)
end

Crossfade.fadeIn = function (self)
    self.targetVolume = 1
end

Crossfade.fadeOut = function (self)
    self.targetVolume = 0
end

Crossfade.crossfade = function (self, track)
    self.targetVolume = 0
    self:loadToTemp(track)
    self.tempSource:play()
end

------------------------------------------------------

Crossfade.update = function (self)
    if self.targetVolume > self.currentSource:getVolume() then
        self.currentSource:setVolume(self.currentSource:getVolume() + self.fadeSpeed)
    elseif self.targetVolume < self.currentSource:getVolume() then
        self.currentSource:setVolume(self.currentSource:getVolume() - self.fadeSpeed)
    end

    if not (self.tempSource == nil) then
        self.tempSource:setVolume(1 - self.currentSource:getVolume())

        if self.currentSource:getVolume() < 0.001 then
            self.currentSource:stop()
            self.currentSource = self.tempSource:clone()
            self.tempSource = nil

            print("SWAPEROO")
        end
    end
end

return Crossfade