local util = require("util")

Grid = { width = 32, height = 32, _grid = { } }

function Grid:new()
    o = {}
    setmetatable(o, self)
    self.__index = self
    for y = 0, o.height do
        o._grid[y] = { }
        for x = 0, o.width do
            o._grid[y][x] = false
        end
    end
    return o
end

function Grid:at(x, y)
    return self._grid[y][x]
end

function Grid:simulate()
    local newgrid = shallowCopy(self._grid)
    for y = 0, self.height do
        for x = 0, self.width do
            local neighbours = 0
            if x > 0 and self:at(x - 1, y) then
                neighbours = neighbours + 1
            end
            if x < self.width - 1 and self:at(x + 1, y) then
                neighbours = neighbours + 1
            end
            if y > 0 then
                if self:at(x, y - 1) then
                    neighbours = neighbours + 1
                end
                if x > 0 and self:at(x - 1, y - 1) then
                    neighbours = neighbours + 1
                end
                if x < self.width - 1 and self:at(x + 1, y - 1) then
                    neighbours = neighbours + 1
                end
            end
            if y < self.height - 1 then
                if self:at(x, y + 1) then
                    neighbours = neighbours + 1
                end
                if x > 0 and self:at(x - 1, y + 1) then
                    neighbours = neighbours + 1
                end
                if x < self.width - 1 and self:at(x + 1, y + 1) then
                    neighbours = neighbours + 1
                end
            end
            if self:at(x, y) then
                if neighbours < 2 then
                    newgrid[y][x] = false
                elseif neighbours <= 3 then
                    newgrid[y][x] = true
                else
                    newgrid[y][x] = false
                end
            else
                if neighbours == 3 then
                    newgrid[y][x] = true
                end
            end 
        end
    end
    self._grid = newgrid
end