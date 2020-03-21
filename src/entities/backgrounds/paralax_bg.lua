local Bg = require("src.entities.scrolling_bg")

--function to create palalax background
local module= function(world)
    local obj = {}

    ---initilisation function
    function obj:new()

        local f1 = "assets/bg1.png"
        self.l1= Bg(f1)
        self.l1.speed = 0.0

        local f2 = "assets/bg2.png"
        self.l2= Bg(f2)
        self.l2.speed = -0.5

        local f3 = "assets/bg3.png"
        self.l3= Bg(f3)
        self.l3.speed = -1.0

        local f4 = "assets/bg4.png"
        self.l4= Bg(f4)
        self.l4.speed = -1.5

        for k,v in pairs(self) do
            world:addTo("bgLayer",v)
        end


    end
    --draw function

     obj:new()
end

return module
