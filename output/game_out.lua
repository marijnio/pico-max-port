
TURN_TREAT_CHOICE = 0
TURN_ROLL_DICE = 1
TURN_SELECT_CHAR = 2
TURN_MOVE_CHAR = 3
TURN_CHECK_CAUGHT = 4
TURN_END = 5

game = {
    state = STATE_TITLE,
    turn_state = TURN_TREAT_CHOICE,
    dice = {
        {result=nil}, 
        {result=nil}  
    },
    active_char = nil,
    chars = {}
}

DICE_SIDES = {"black", "green"}

debug = nil

function init_game()
  player_turn = 1
  max_position = 0
  add(game.chars, make_char("max", 1, false))
  add(game.chars, make_char("mouse", 4, true))
  
  
  init_board()
  printh("game initialized")
  
end


function update_game()
  if game.turn_state == TURN_TREAT_CHOICE then
    update_treat_choice()
  elseif game.turn_state == TURN_ROLL_DICE then
    update_roll_dice()
  elseif game.turn_state == TURN_SELECT_CHAR then
    update_select_char()
  elseif game.turn_state == TURN_MOVE_CHAR then
    update_move_char()
  elseif game.turn_state == TURN_CHECK_CAUGHT then
    update_check_caught()
  elseif game.turn_state == TURN_END then
    update_turn_end()
  end
end


function update_treat_choice()
  
  
  
  
  
  

  game.turn_state = TURN_ROLL_DICE

end

function update_roll_dice()
  if btnp(4) then
    roll_dice()

    for d in all(game.dice) do
      printh(d.result)
    end
    
    game.turn_state = TURN_SELECT_CHAR
  end
end

function roll_dice()
  for d in all(game.dice) do
    d.result = DICE_SIDES[flr(rnd(2)) + 1]
    printh(DICE_SIDES[1])
    
  end

  
  
  
  
  
  
  

  
  
end

function update_select_char()

  
  for c in all(game.chars) do
    c.can_move = can_char_move(c)
  end

  
  if btnp(0) then next_valid_char(-1) end  
  if btnp(1) then next_valid_char(1) end   

  local selected = game.chars[game.selected_index]

  
  if btnp(4) and can_char_move(selected) then 
    game.active_char = selected.name
    game.turn_state = TURN_MOVE_CHAR
  end
end

function update_move_char()
  move_character(game.active_char)

  
  local c = get_char(game.active_char)
  if c.is_critter then
    game.green_moves -= 1
  else
    game.black_moves -= 1
  end

  
  game.moves_left = game.black_moves + game.green_moves

  
  if game.moves_left <= 0 then
    game.turn_state = TURN_CHECK_CAUGHT
  else
    game.turn_state = TURN_SELECT_CHAR
  end
end

function update_check_caught()
  if any_critter_caught() then
    remove_caught_critters()
  end

  game.turn_state = TURN_END
end

function update_turn_end()
  
  next_player_turn()
  game.turn_state = TURN_TREAT_CHOICE
end

function next_player_turn()
  
  for d in all(game.dice) do
    d.result = nil
  end
  game.black_moves = 0
  game.green_moves = 0
  game.moves_left = 0
  game.active_char = nil
  game.selected_index = 1
end

function use_treat()
  game.treats_left -= 1
  reset_max_position()
end

function get_char(name)
  for c in all(game.chars) do
    if c.name == name then return c end
  end
end

function reset_max_position()
  local max = get_char("max")
  max.x, max.y = max.start_x, max.start_y
end

function move_character(name)
  local c = get_char(name)
  if c.caught then return end

  c.pos += 1 
  if c.pos > BOARD_SIZE then
    c.pos = BOARD_SIZE 
  end
end

function any_critter_caught()
  local max = get_char("max")
  for c in all(game.chars) do
    if c.is_critter and not c.caught and c.x == max.x and c.y == max.y then
      return true
    end
  end
  return false
end

function remove_caught_critters()
  local max = get_char("max")
  for c in all(game.chars) do
    if c.is_critter and not c.caught and c.x == max.x and c.y == max.y then
      c.caught = true
    end
  end
end

function next_valid_char(dir)
  local total = #game.chars
  for i=1,total do
    game.selected_index = ((game.selected_index - 1 + dir) % total) + 1
    local c = game.chars[game.selected_index]
    if can_char_move(c) then return end
  end
end

function can_char_move(c)
  
  if c.caught then return false end
  
  if c.is_critter and dice_left("green") <= 0 then return false end
  if not c.is_critter and dice_left("black") <= 0 then return false end
  return true
end

function dice_left(color)
  local count = 0
  for d in all(game.dice) do
    if d.result == color or color == "" then count += 1 end
  end
  return count
end


function draw_game()
  cls()
  
  for i=1,BOARD_SIZE do
      rectfill(board[i].x, board[i].y, board[i].x+7, board[i].y+7, 5)
  end

  
  
  for i, c in ipairs(game.chars) do
    if c.pos ~= nil and board[c.pos] then
      
      local cell = board[c.pos]
      
      
      local col = c.can_move and 11 or 8

      
      rectfill(cell.x+1, cell.y+1, cell.x+6, cell.y+6, col)
      
    end
  end
  
  
  if game.dice then
      local dice_text = "dice: "
      for i, d in ipairs(game.dice) do
          dice_text = dice_text .. (d.result or "?")
          if i < #game.dice then dice_text = dice_text .. ", " end
      end
      print(dice_text, 2, 2, 7)
  end

  
  local turn_states = {
      [TURN_TREAT_CHOICE] = "treat choice",
      [TURN_ROLL_DICE] = "roll dice",
      [TURN_SELECT_CHAR] = "select character",
      [TURN_MOVE_CHAR] = "move character",
      [TURN_CHECK_CAUGHT] = "check caught",
      [TURN_END] = "turn end"
  }
  print("turn state: "..(turn_states[game.turn_state] or "unknown"), 2, 18, 7)

end