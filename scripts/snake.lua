

-- initial snake's state
function load_snake()

  tab_snake = {
    
    {8, 5},
    {7, 5},
    {6, 5},
    {5, 5}
    
  }
  
  SNAKE_LENGHT = #tab_snake

end


function move_snake_right()

  -- reset lvl
  reset_lvl()
  
  -- Move de la tête X+
  local x = tab_snake[1][1] + 1
  local y = tab_snake[1][2]
  
  if x > NB_TILES_X then
    print("lose X+")
    LOSE = true
  else
    table.insert(tab_snake, 1, {x, y})
    
    -- Delete du dernier élément
    table.remove(tab_snake)
    
    -- collision with snake's body ?
    check_auto_collision()
    
    -- eat apple ?
    check_apple()
    
    -- update lvl
    update_lvl()
  end 
end

function move_snake_left()
  -- reset lvl
  reset_lvl()
  
    -- Move de la tête X-
  local x = tab_snake[1][1] - 1
  local y = tab_snake[1][2]
  
  if x <= 0 then
    print("lose X0")
    LOSE = true
  else
    table.insert(tab_snake, 1, {x, y})
    
    -- Delete du dernier élément
    table.remove(tab_snake)
    
    -- collision with snake's body ?
    check_auto_collision()
    
    -- eat apple ?
    check_apple()
    
    -- update lvl
    update_lvl()
  end
end

function move_snake_up()
  -- reset lvl
  reset_lvl()
  
    -- Move de la tête Y-
  local x = tab_snake[1][1]
  local y = tab_snake[1][2] - 1
  
  if y <= 0 then
    print("lose Y0")
    LOSE = true
  else
    table.insert(tab_snake, 1, {x, y})
  
    -- Delete du dernier élément
    table.remove(tab_snake)
    
    -- collision with snake's body ?
    check_auto_collision()
    
    -- eat apple ?
    check_apple()
    
    -- update lvl
    update_lvl()
  end
end

function move_snake_down()
  -- reset lvl
  reset_lvl()
  
  -- Move de la tête Y+
  local x = tab_snake[1][1]
  local y = tab_snake[1][2] + 1
  
  if y > NB_TILES_Y then
    print("lose Y+")
    LOSE = true
  else
    table.insert(tab_snake, 1, {x, y})
    
    -- Delete du dernier élément
    table.remove(tab_snake)
    
    -- collision with snake's body ?
    check_auto_collision()
    
    -- eat apple ?
    check_apple()
    
    -- update lvl
    update_lvl()
  end
end

function print_snake()
  for i = 1, #tab_snake do
    print('X = ' .. tab_snake[i][1] .. '  ' .. 'Y= ' .. tab_snake[i][2])
  end  
end

-- update tab_lvl with snake position
function update_lvl()
  
  for i = 1, #tab_snake do
    local x = tab_snake[i][1]
    local y = tab_snake[i][2]
    tab_lvl[y][x] = 1
  end
  print('X = ' .. tab_snake[1][1] .. '  ' .. 'Y= ' .. tab_snake[1][2])
end

--erase last snake's position
function reset_lvl()
  
  for i = 1, #tab_snake do
    local x = tab_snake[i][1]
    local y = tab_snake[i][2]
    tab_lvl[y][x] = 0
  end
  
end

-- test if snake take an apple
function check_apple()
  local x = tab_snake[1][1]
  local y = tab_snake[1][2]
  
  if tab_lvl[y][x] == 2 then
      table.insert(tab_snake, 1, {x, y})
      NB_APPLE_EAT = NB_APPLE_EAT + 1
      SNAKE_LENGHT = #tab_snake
      rand_apple()
      love.audio.play(sound_capture_apple)
      
      -- if eat apple, then inscrease snake's cel
      if CELERITY >= CELERITY_MAX then
        CELERITY = CELERITY - 0.005  
      end
      
  end
  
end

-- test if snake is out of the game
function check_board()
  local x = tab_snake[1][1]
  local y = tab_snake[1][2]
  
  if x > NB_TILES_X then
    print("lose X")
  end
  
  if x < 0 then
    print("lose X0")
  end
  
  if y < 0 then
    print("lose Y0")
  end
  
  if y > NB_TILES_Y then
    print("lose Y")
  end
  
  
end

-- test if snake's head collide his body
function check_auto_collision()
  local x = tab_snake[1][1]
  local y = tab_snake[1][2]
  
  for i = 2, #tab_snake do
    if tab_snake[i][1] == x and tab_snake[i][2] == y then
      print("collision snake")
      LOSE = true
    end
  end
    
end
