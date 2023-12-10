-- crop class
-- graphical representations of the note frequency output parameters (bandsaw)

local crop = {}
crop.__index = rule

function crop:new(crop_type, origin, size, divisions)
  local c = {}
  setmetatable(c, crop)
  
  c.crop_type = crop_type
  c.origin = origin
  c.size = size
  c.divisions = divisions or nil

  function c:display(crop_screen_level)
    if c.crop_type == "arc" then
      local theta1, theta2
      if math.rad(c.divisions.x) < math.rad(c.divisions.y) then
        theta1=math.rad(c.divisions.x)
        theta2=math.rad(c.divisions.y)
      else
        theta1=math.rad(c.divisions.y)
        theta2=math.rad(c.divisions.x)
      end

      local origin_vector = vector:new(c.origin.x, c.origin.y)
      local line_vector = vector:new(c.size.x/2,0)
      -- screen.move(origin_vector.x, origin_vector.y)
      -- screen.line_rel(line_vector.x,line_vector.y)
      screen.move(c.origin.x, c.origin.y)
      screen.circle(c.size.x/2)
      -- screen.arc(c.size.x/2, theta1, theta2)
      -- screen.fill()
      if c.divisions.y < 360 then
        local origin_vector = vector:new(c.origin.x, c.origin.y)
        local line_vector = vector:new(c.size.x/2,0)
        -- screen.move(origin_vector.x, origin_vector.y)
        -- screen.line_rel(line_vector.x,line_vector.y)
        screen.move(c.origin.x, c.origin.y)
        -- screen.arc(c.size.x/2, theta1, theta2)
        screen.level(crop_screen_level-4)
        screen.circle_fill(c.size.x/2)
        -- screen.fill()
      end
    else
      screen.move(c.origin.x, c.origin.y)
      screen.rect_fill(c.size.x-1, c.size.y-1)
      -- screen.fill()
      if c.divisions.y < 360 then
        local pct_division = c.divisions.y/360
        screen.move(c.origin.x, c.origin.y)
        screen.level(crop_screen_level-4)
        screen.rect_fill((c.size.x-1) * pct_division, c.size.y-1)
        -- screen.fill()
      end
    end
  end

  function c.set_id(id)
    c.id = id
  end
  
  function c.move_origin(vector)
    c.origin:add(vector)
  end
  
  function c.set_size(vector)
    c.size = vector:new(vector.x,vector.y)
  end
  
  function c.set_id(id)
    c.id = id
  end
  
  function c.get_id()
    return c.id
  end
  
  function c.get_type()
    return c.crop_type
  end
  
  function c.get_origin()
    return c.origin
  end
  
  function c.get_size()
    return c.size
  end

  return c
end

return crop
