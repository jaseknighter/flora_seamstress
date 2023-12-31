-- screen instructions: accessed by pressing Key 1 (K1) and Key 2 (K2)

local instructions = {}

instructions.display = function ()
  screen.level(15)
  screen.move(5,20)
  screen.text("e1: next/prev page")
  screen.move(5, 28)

  if pages.index < 5 then
    screen.text("E2: select active plant")
    screen.move(5, 36)
  end

  if (pages.index == 1) then
    screen.text("e2: change plant")
    screen.move(5, 44)
    screen.text("e3: -/+ angle")
    screen.move(5, 52)
    screen.text("k2/k3: prev/next generation")
    -- screen.move(5, 60)
    -- screen.text("k1 + k3: reset plants")
  elseif (pages.index == 2) then
    screen.text("e2: select control")
    if modify.active_control > 1 and modify.active_control <= modify.num_rulesets * 2 + 2 then
      if modify.active_control <= modify.num_rulesets * 2 + 1 then
        if (modify.active_control - 1) % 2 == 1 then
          -- "pre"
          screen.move(5, 44)
          screen.text("E3: change letter value")
        else
          -- "post"
          screen.move(5, 44)
          screen.text("e3: select character")
          screen.move(5, 52)
          screen.text("E3: change letter value")
          screen.move(5, 60)
          screen.text("k2/k3: delete/add letter")
        end
      elseif modify.active_control <= modify.num_rulesets * 2 + 2 then
        -- "axiom"
        screen.move(5, 44)
        screen.text("e3: select character")
        screen.move(5, 52)
        screen.text("E3: change letter value")
        screen.move(5, 60)
        screen.text("k2/k3: delete/add letter")
      end
    else 
      screen.move(5, 44)
      screen.text("E3: change control value")
    end 
  elseif (pages.index == 3) then
    screen.text("e2: move up/down")
    screen.move(5, 44)
    screen.text("e3: move left/right")
    screen.move(5, 52)
    screen.text("k2/k3: zoom out/in")
    screen.move(5, 60)
    -- screen.text("k1 + k3: reset plants")
  elseif (pages.index == 4) then
    screen.text("e2: select control")
    screen.move(5, 44)
    screen.text("e3: -/+ control value")
    screen.move(5, 52)
    screen.text("e3: -/+ control value (fine)")
    screen.move(5, 60)
    screen.text("k2/k3: -/+ control point")
    -- screen.move(5, 60)
    -- screen.text("k1 + k3: show mod controls")
  elseif (pages.index == 5) then
    screen.text("e2: select control")
    screen.move(5, 36)
    screen.text("e3: change control value")
  elseif (pages.index == 6) then
    screen.text("see github for tinta instr")    
  end
  --screen.update()
end

return instructions
