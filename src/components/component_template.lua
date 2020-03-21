local module= function()
    local obj = {}
    ---initilisation function
    function obj:new()
        
        return self
    end
    --draw function
    function obj:draw()
        
    end
    --update function
    function obj:update(dt)
        
    end
    return obj:new()
end

return module