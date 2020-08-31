local grid = require("grid")

function love.load()
    down = false
    start = false
    t = 0
    grid = Grid:new()
    tilewidth = love.graphics.getWidth() / grid.width
    tileheight = love.graphics.getHeight() / grid.height
end

function love.draw()
    for y = 0, grid.height do
        for x = 0, grid.width do
            if grid:at(x, y) then
                love.graphics.setColor(255, 255, 255)
                love.graphics.rectangle("fill", x * tilewidth, y * tileheight, tilewidth, tileheight)
            end
        end
    end
end

function love.update()
    if not start and love.mouse.isDown(1) then
        if not down then
            x = math.floor(love.mouse.getX() / tilewidth)
            y = math.floor(love.mouse.getY() / tileheight)
            grid._grid[y][x] = not grid._grid[y][x]
        end 
        down = true
    else
        down = false
    end
    if start then
        t = t + love.timer.getDelta()
        if t >= 1.0 then
            grid:simulate()
            t = 0.0
        end
    end
    if love.keyboard.isDown("space") then 
        start = true
    end
end