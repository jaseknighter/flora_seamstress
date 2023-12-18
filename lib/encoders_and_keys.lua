function enc_key_visualizer()
  -- put visualizer in the top right corner
  screen.level(11)
  screen.move(screen_size.x-20,1)
  screen.rect(21,9)
  screen.level(3)
  screen.move(screen_size.x-19,2)
  screen.rect_fill(19,7)
  screen.level(5)
  screen.level((encoder_activated1==true and shift_pressed==true) and (lrarrow_pressed == false and 10 or 15) or 5)
  screen.pixel(screen_size.x-17,4)--k1
  screen.level((encoder_activated1==true and shift_pressed==false) and (lrarrow_pressed == false and (encoder_pressed1 == true and 13 or 10) or 15) or 5)
  screen.move(screen_size.x-14,4)--e1
  screen.circle(1)--e1
  screen.level((encoder_activated2==true and shift_pressed==false) and (lrarrow_pressed == false and  (encoder_pressed2 == true and 13 or 10) or 15) or 5)
  screen.move(screen_size.x-9,5)--e2
  screen.circle(1)--e2
  screen.level((encoder_activated3==true and shift_pressed==false) and (lrarrow_pressed == false and  (encoder_pressed3 == true and 13 or 10) or 15) or 5)
  screen.move(screen_size.x-4,5)--e3
  screen.circle(1)--e3
  screen.level((encoder_activated2==true and shift_pressed==true) and (lrarrow_pressed == false and 10 or 15) or 5)
  screen.pixel(screen_size.x-11,7)--k2
  screen.level((encoder_activated3==true and shift_pressed==true) and (lrarrow_pressed == false and 10 or 15) or 5)
  screen.pixel(screen_size.x-6,7)--k3
end

-- encoders and keys
screen.key = function (char,modifiers,is_repeat,state)
  if pages.index > 3 then screen_dirty=true end
  local repeat_on_is_repeat = true
  local repeat_check = true
  if repeat_on_is_repeat == true and is_repeat == true then
    repeat_check = true
  elseif repeat_on_is_repeat == false and is_repeat == true then
    repeat_check = false
  else
    repeat_check = true
  end

  if char.name and string.find(char.name, "shift")~=nil then
    if state == 1 then
      shift_pressed = true      
    else
      shift_pressed = false      
    end
  end

  if char.name and string.find(char.name, ENCODER_KEYVALS[params:get('e1')])~=nil then
    if state == 1 then
      encoder_activated1 = true
      encoder_pressed1 = true
      alt_key_active = true
      if encoder_pressed2 == false then encoder_activated2 = false end
      if encoder_pressed3 == false then encoder_activated3 = false end
    else
      if encoder_pressed2 or encoder_pressed3 then
        encoder_activated1 = false
        encoder_activated2 = false
        encoder_activated3 = false
      end
      encoder_pressed1 = false
      alt_key_active = false
    end
  elseif char.name and string.find(char.name, ENCODER_KEYVALS[params:get('e2')])~=nil then
    if state == 1 then
      encoder_activated2 = true
      encoder_pressed2 = true
      alt_key_active = true
      if encoder_pressed1 == false then encoder_activated1 = false end
      if encoder_pressed3 == false then encoder_activated3 = false end
    else
      if encoder_pressed1 or encoder_pressed3 then
        encoder_activated1 = false
        encoder_activated2 = false
        encoder_activated3 = false
      end
      encoder_pressed2 = false
      alt_key_active = false
    end
  elseif char.name and string.find(char.name, ENCODER_KEYVALS[params:get('e3')])~=nil then
    if state == 1 then
      encoder_activated3 = true
      encoder_pressed3 = true
      alt_key_active = true
      if encoder_pressed1 == false then encoder_activated1 = false end
      if encoder_pressed2 == false then encoder_activated2 = false end
    else
      if encoder_pressed1 or encoder_pressed2 then
        encoder_activated1 = false
        encoder_activated2 = false
        encoder_activated3 = false
      end
      encoder_pressed3 = false
      alt_key_active = false
    end
  end
  
  if encoder_activated2 == false and encoder_activated3 == false then
    show_instructions = false
  end

  if char and char.name == "left" and repeat_check == true then
    lrarrow_pressed = state==1 and true or false
    if encoder_activated1 == true then
      if shift_pressed == false and state == 1 then 
        enc(1,-1)
      elseif shift_pressed == true and state == 1 then
        key(1,1)
      elseif shift_pressed == true and state == 0 then
        key(1,0)
      end
    elseif encoder_activated2 == true then
      if shift_pressed == false and state == 1 then 
        enc(2,-1)
      elseif shift_pressed == false and state == 0 then 
        show_instructions = false      
      elseif shift_pressed == true and state == 1 then
        key(2,1)
      elseif shift_pressed == true and state == 0 then
        key(2,0)
      end
    elseif encoder_activated3 == true then
      if shift_pressed == false and state == 1 then 
        enc(3,-1)
      elseif shift_pressed == true and state == 1 then
        key(3,1)
      elseif shift_pressed == true and state == 0 then
        key(3,0)
      end
    end
  elseif char and char.name == "right" and repeat_check == true then 
    lrarrow_pressed = state==1 and true or false
    if encoder_activated1 == true then
      if shift_pressed == false and state == 1 then 
        enc(1,1)
      elseif shift_pressed == true and state == 1 then
        key(1,1)
      elseif shift_pressed == true and state == 0 then
        key(1,0)
      end
    elseif encoder_activated2 == true then
      
      if shift_pressed == false and state == 1 then 
        enc(2,1)
      elseif shift_pressed == false and state == 0 then 
        show_instructions = false      
      elseif shift_pressed == true and state == 1 then
        key(2,1)
      elseif shift_pressed == true and state == 0 then
        key(2,0)
      end
    elseif encoder_activated3 == true then
      if shift_pressed == false and state == 1 then 
        enc(3,1)
      elseif shift_pressed == true and state == 1 then
        key(3,1)
      elseif shift_pressed == true and state == 0 then
        key(3,0)
      end
    end
  end
  if pages.index==6 and char.name==nil and state == 1 then
    if shift_pressed then
      t.str = t.str .. kc.shifted[char]
    else
      t.str = t.str .. char
    end
    t.redraw()
  end

  local code = char.name == nil and char or char.name
  
  if pages.index==6 and state == 1 then
    if val == 0 then      
      if string.sub(code,#code-3)  == "CTRL" then 
        t.ctrl_down = false
      end
      return 
    end
    if code == "BACKSPACE" or code == "backspace" then
      t.str = t.str:sub(1, -2)
    elseif code == "UP" or code == "up" then
      if t.ctrl_down == true then
        t.cmds_idx = util.wrap(t.cmds_idx-1,1,#t.cmds)
        t.str = t.cmds[t.cmds_idx][1]..t.cmds[t.cmds_idx][2]
      else
        if #t.history == 0 then return end
        if t.new_line then
          t.history_index = #t.history - 1
          t.new_line = false
        else
          t.history_index = util.clamp(t.history_index - 1, 0, #t.history)
        end
        t.str = t.history[t.history_index + 1]
      end
    elseif code == "DOWN" or code == "down" then
      if t.ctrl_down == true then
        t.cmds_idx = util.wrap(t.cmds_idx+1,1,#t.cmds)
        t.str = t.cmds[t.cmds_idx][1]..t.cmds[t.cmds_idx][2]
      else
        if #t.history == 0 or t.history_index == nil then return end
        t.history_index = util.clamp(t.history_index + 1, 0, #t.history)
        if t.history_index == #t.history then
          t.str = ""
          t.new_line = true
        else
          t.str = t.history[t.history_index + 1]
        end
      end
    elseif (code == "ENTER" or code == "return" ) and t.cmd_ok == true and #t.str>0 then
      table.insert(t.history, t.str)
      t.str = ""
      t.history_index = #t.history
      t.new_line = true

      if t.cmd == 1 then -- update octaves
        local tbl = t.str_to_tab(t.cmd_params)
        -- for i=1,#tbl do -- IMPORTANT: keep octaves below 3 so things don't blow up
        --   if tbl[i] > 2 then tbl[i] = 2 end 
        -- end
        t.oct = s{table.unpack(tbl)}
      elseif t.cmd == 2 then -- update tinta melody
        local tbl = t.str_to_tab(t.cmd_params)
        t.tin = s{table.unpack(tbl)}
      elseif t.cmd == 3 then -- update velocities
        local tbl = t.str_to_tab(t.cmd_params)
        t.vel = s{table.unpack(tbl)}
      elseif t.cmd == 4 then -- update rhythm
        local tbl = t.str_to_tab(t.cmd_params)
        t.set_rhythm(tbl)
      elseif t.cmd == 5 then -- start the tinta pattern
        params:set("tin_enabled",2)
      elseif t.cmd == 6 then -- stop the tinta pattern
        params:set("tin_enabled",1)
      elseif t.cmd == 7 then -- dance on
        params:set("tin_dancing_notes",2)
      elseif t.cmd == 8 then -- dance off
        params:set("tin_dancing_notes",1)
      elseif t.cmd == 9 then -- start envelope morph
        params:set("tin_env_morph",2)
      elseif t.cmd == 10 then -- stop envelope morph 
        params:set("tin_env_morph",1)
      elseif t.cmd == 11 then -- set duration off morphing envelope in beats
        local tbl = t.str_to_tab(t.cmd_params)
        t.set_edu(tbl)
      elseif t.cmd == 12 then -- set steps of to morph envelope
        local tbl = t.str_to_tab(t.cmd_params)
        t.set_est(tbl)
      elseif t.cmd == 13 then -- set shape of morphing envelope
        local tbl = t.str_to_tab(t.cmd_params)
        t.set_esh(tbl)
      elseif keyboard.ctrl() then
        if t.ctrl_down == false then
          t.ctrl_down = true
        end
      end
      t.history_index = #t.history
      -- table.remove(t.history,#t.history)
      -- t.history_index = #t.history
      -- t.str = ""
    end
    t.redraw()
    -- grid_redraw()
  end

end


local enc = function (n, delta)
  -- set variables needed by each page/example
  if show_instructions == false and initializing == false then
    if n == 1 then
      --screen.clear()

      if (alt_key_active == false) then
        -- scroll pages
        local page_increment = util.clamp(delta, -1, 1)

        local next_page = pages.index + page_increment
        if (next_page <= num_pages and next_page > 0) then
          -- Page scroll
          for i=1,#plants,1
          do
            plants[i].set_current_page(next_page)
          end
          page_scroll(page_increment)
          set_midi_channels()
        end
        --screen.clear()
        if (pages.index == 4 or pages.index == 6) then
        end
      end
    elseif n == 2 then 
      --screen.clear()
      
      if encoder_activated2 == true and encoder_activated3 == true then
        show_instructions = true
    
      elseif pages.index < 5 and alt_key_active == true then
        plants[active_plant].switch_active_plant()
      elseif (pages.index == 1) then
        -- change instruction for active plant
        --screen.clear()
        local rotate_by = util.clamp(delta, -1, 1)
        clock.run(plants[active_plant].set_instructions,rotate_by,0,true)
      elseif pages.index == 2 then
        local increment = util.clamp(delta, -1, 1)
        modify.enc(n, delta, alt_key_active)     
        -- plants[active_plant].increment_sentence_cursor(increment)
      elseif pages.index == 3 then
        -- move active plant along the x-axis
        plants[active_plant].set_offset(0,delta)
      elseif pages.index == 4 then
        envelopes[active_plant].enc(n, delta, alt_key_active)     
      elseif pages.index == 5 then
        water.enc(n, delta, alt_key_active)     
      end
    elseif n == 3 then 
      --screen.clear()
      if pages.index == 1 then
        plants[active_plant].set_angle(util.clamp(delta, -1, 1))
      elseif pages.index == 2 then
        local incr = util.clamp(delta, -1, 1) 
        modify.enc(n, delta, alt_key_active)     
        -- plants[active_plant].change_letter(incr)
      elseif pages.index == 3 then
        -- move active plant along the y-axis
        plants[active_plant].set_offset(delta,0)
      elseif pages.index == 4 then
        envelopes[active_plant].enc(n, delta)     
      elseif pages.index == 5 then
        water.enc(n, delta, alt_key_active)  
      end
    end
  end
  -- set_dirty()
  screen_dirty=true

end

local key = function (n,z)
  
    if n == 2 and alt_key_active == true and show_instructions == true then
      if pages.index == 5 then
        water.display()
      end
    end

  -- if n == 2 and z== 0 then
  --   show_instructions = false
  -- end
  -- if show_instructions == false then
    -- if (n == 2 and z == 1 and alt_key_active == false) then 
    if (n == 2 and z == 1) then 
      if pages.index == 1 then
        plants[active_plant].set_instructions(0,-1)
      elseif (pages.index == 2) then
        modify.key(n, z)
      elseif(pages.index == 3) then
        plants[active_plant].set_node_length(0.9)
      elseif pages.index == 4 then
        envelopes[active_plant].key(n, delta)
      elseif pages.index == 5 then
        -- water.key(n, delta, alt_key_active)
      end
    -- elseif (n == 2 and z == 0)  then 
    --   if pages.index == 2  and alt_key_active == false then
    --     modify.key(n, z)
    --   elseif pages.index == 4 then
    --     envelopes[active_plant].key(n, delta)
    --   elseif pages.index == 5 then
    --     water.key(n, delta, alt_key_active)
    --   end
    elseif (n == 3 and z == 1)  then 
      if pages.index == 1 then
        plants[active_plant].set_instructions(0,1)
      elseif pages.index == 2  then
        modify.key(n, z)
      elseif pages.index == 3 then
        plants[active_plant].set_node_length(1.1)
      elseif pages.index == 4 then
        envelopes[active_plant].key(n, delta)
      elseif pages.index == 5 then
        water.key(n, delta, alt_key_active)
      end
    end
  
  
  -- on pages 1-3 sync plants from start of sequences
  if (n == 3 and alt_key_active == true and pages.index < 4) then
    -- plants[1].set_instructions(0)
    -- plants[2].set_instructions(0)
  end
  screen_dirty=true
end

return{
  enc=enc,
  key=key
}
