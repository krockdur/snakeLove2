--[[

SnakeLua - v0.1
@Krockdur #JF72
git push -u origin master

Versions :
lua : 5.35
love2d : 	11.3

]]

-- requires
require('scripts.const')
require('scripts.lvl')
require('scripts.snake')

-- configuration
  -- active les traces dans la console
io.stdout:setvbuf('no')

  -- meilleur rendu avec du pixel art
love.graphics.setDefaultFilter('nearest')

  -- permet de faire du debug pas à pas dans ZeroBraneStudio
if arg[#arg] == '-debug' then require('mobdebug').start() end


-- Initilisation
function love.load()
  -- définition de la fenêtre de jeu
  love.window.setMode(WIN_WIDTH, WIN_HEIGHT, {highdpi = true, fullscreen = false})
  
  -- Chargement des sprites
  img_background = love.graphics.newImage("assets/background.png")
  sprite_bg = love.graphics.newImage("assets/tile_bg.png")
  sprite_snake = love.graphics.newImage("assets/tile_snake.png")
  sprite_food = love.graphics.newImage("assets/tile_food.png")
  --
  
  -- UI
  font = love.graphics.newFont("assets/SnesItalic-vmAPZ.ttf", 40)
  font_lose = love.graphics.newFont("assets/SnesItalic-vmAPZ.ttf", 80)
  
  text_lose = love.graphics.newText(font_lose, "PERDU")
  text_score = love.graphics.newText(font, "SCORE")
  text_lenght = love.graphics.newText(font, "LONGUEUR")
  text_nb_apple = love.graphics.newText(font, tostring(NB_APPLE_EAT))
  text_snake_lenght = love.graphics.newText(font, tostring(SNAKE_LENGHT))
  
  -- chargement du snake
  load_snake()
  print_snake()
  direction = "right"
  
  -- init timer
  timer = 0

end


-- on dessine la vue
function love.draw()

  
  -- Background

  love.graphics.draw(img_background, 0, 0)
  
    -- UI
  love.graphics.setColor(0, 0, 0, 255)
  
  text_nb_apple:set(tostring(NB_APPLE_EAT))
  text_snake_lenght:set(tostring(SNAKE_LENGHT))
  
  love.graphics.draw(text_score, 690, 50)
  love.graphics.draw(text_nb_apple, 710, 85)
  love.graphics.draw(text_snake_lenght, 710, 185)
  love.graphics.draw(text_lenght, 675, 150)
  
  if LOSE == true then
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.draw(text_lose, 300, 200)
  end
  
  
  love.graphics.setColor(255, 255, 255, 255)
   
   
   
  -- On dessine la tilemap en fonction du type de tuile
  for j=0, NB_TILES_Y-1 do
    for i=0, NB_TILES_X-1 do
      
	
      
      if tab_lvl[j+1][i+1] == 1 then
        love.graphics.draw(sprite_snake, i * TILE_WIDTH + OFFSET_1ST_TILE_X, j * TILE_HEIGHT + OFFSET_1ST_TILE_Y)
      end
      
      if tab_lvl[j+1][i+1] == 2 then
        love.graphics.draw(sprite_food, i * TILE_WIDTH + OFFSET_1ST_TILE_X, j * TILE_HEIGHT + OFFSET_1ST_TILE_Y)
      end
     
    end
 
  end

--

end



-- Boucle
function love.update(dt)
  -- Mise en pause en fonction du focus
  if gameIsPaused then return end
  

  if not LOSE then
    
    -- timer
    timer = timer + dt
    local 	timer_limit = CELERITY
    if timer >= timer_limit then
      
      timer = timer - timer_limit
      
      if (direction == "right") then
        move_snake_right()
      end
      
      if (direction == "left") then
        move_snake_left()
      end
      
      if (direction == "up") then
        move_snake_up()
      end
      
      if (direction == "down") then
        move_snake_down()
      end
      
    end
  else
    print("PERDU")
  end
end


-- les contrôles
function love.mousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
end

function love.keypressed(key)
  if key == 'q' then
    direction = "left"
  end
  if key == 'd' then
    direction = "right"
  end
  if key == 'z' then
    direction = "up"
  end
  if key == 's' then
    direction = "down"
  end
  
end

function love.keyreleased(key)
end


-- function love.focus(f) gameIsPaused = not f end
function love.focus(f)
  if not f then
    print("focus perdu")
    gameIsPaused = true
  else
    gameIsPaused = false
    print("focus fenetre")
  end
end

function love.quit()
  print("END GAME")
end


-- https://love2d.org/wiki/Tutorial:Callback_Functions
-- https://wxlua.developpez.com/tutoriels/lua/general/cours-complet/
