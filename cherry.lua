--[[
    Cherry Engine
    Mizu, 2022

    github: rexxt/cherry-rg-engine

    General engine to keep track of the beats of a song.
    Most useful for rhythm games.

    Depends on the "classic" library.
    github: rxi/classic
]]

-- make sure classic.lua is present in this directory
-- if it isn't, run install_deps.sh
Object = require "classic"

local Engine = Object:extend()

function Engine:new(bpm, beat)
    self.bpm = bpm or 120
    self.bps = self.bpm/60
    self.beat = beat or 0

    self.new_beats = 0
    self.time = 0

    self.bpm_changes = {}
    self.events = {}
end

function Engine:add_bpm_change(beat, bpm)
    table.insert(self.bpm_changes, {
        on = beat,
        new_bpm = bpm
    })
end

function Engine:add_event(beat, properties)
    table.insert(self.events, {
        on = beat,
        properties = properties
    })
end

function Engine:remove_bpm_change(n)
    return table.remove(self.bpm_changes, n)
end

function Engine:remove_event(n)
    return table.remove(self.events, n)
end

function Engine:step(sec)
    self.time = self.time + sec
    if #self.bpm_changes > 0 then
        for i, v in pairs(self.bpm_changes) do
            if self.beat + self.bps*sec >= v.on then
                local old_bpm = self.bpm
                local s2 = sec
                self.bpm = v.new_bpm
                self.bps = 1/self.bpm*60
                s2 = s2 - self.bps*(v.on-self.beat)
                self.beat = v.on
                self.beat = self.beat + self.bps*s2
            else
                self.beat = self.beat + self.bps*sec
            end
        end
    else
        self.beat = self.beat + self.bps*sec
    end
end

return Engine