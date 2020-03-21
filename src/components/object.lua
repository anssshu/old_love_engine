local module= function()
    local obj = {}
    ---initilisation function
    function obj:new()
        return self
    end
    function obj:extend(superclass)
        for k,v in pairs(superclass) do 
            if obj[k] == nil then 
                obj[k] = v
            end
        end
    end
    --update function
    function obj:print()
        for k,v in pairs(obj)do 
            print(k,v)
        end
    end

    return obj:new()
end

return module