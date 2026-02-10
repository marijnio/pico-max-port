
TURN_START = 0
TURN_TREAT_CHOICE = 1
TURN_ROLL_DICE = 2
TURN_SELECT_CHAR = 3
TURN_CHOOSE_STEPS = 4
TURN_MOVE_CHAR = 5
TURN_CHECK_CAPTURE = 6
TURN_END = 7

game = {
    state = STATE_TITLE,
    turn_state = TURN_TREAT_CHOICE,
    dice = {
        {result=nil}, 
        {result=nil}  
    },
    chars = {},
    selected_index = 1,
    steps_to_move = 0,
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
  if game.turn_state == TURN_START then
    update_turn_start()
  elseif game.turn_state == TURN_TREAT_CHOICE then
    update_treat_choice()
  elseif game.turn_state == TURN_ROLL_DICE then
    update_roll_dice()
  elseif game.turn_state == TURN_SELECT_CHAR then
    update_select_char()
  elseif game.turn_state == TURN_CHOOSE_STEPS then
    update_choose_steps()
  elseif game.turn_state == TURN_MOVE_CHAR then
    update_move_char()
  elseif game.turn_state == TURN_CHECK_CAPTURE then
    update_check_capture()
  elseif game.turn_state == TURN_END then
    update_turn_end()
  end
end

function update_turn_start()  
  game.turn_state = TURN_TREAT_CHOICE
end


function update_treat_choice()
  
  
  
  
  
  

  game.turn_state = TURN_ROLL_DICE

end

function update_roll_dice()
  if btnp(4) then
    roll_dice()

    game.turn_state = TURN_SELECT_CHAR
  end
end

function roll_dice()
  for d in all(game.dice) do
    d.result = DICE_SIDES[flr(rnd(2)) + 1]
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
    game.turn_state = TURN_CHOOSE_STEPS
  end
end

function update_choose_steps()
  
  steps_to_move = 1 
  game.turn_state = TURN_MOVE_CHAR
end

function move_character(index, steps)
  local c = game.chars[index]
  printh("moving "..c.name.." by "..steps.." steps")
  c.pos += steps
end

function update_check_capture()
  if any_critter_caught() then
    remove_caught_critters()
  end

  game.turn_state = TURN_END
end

function update_turn_end()  
  
  for d in all(game.dice) do
    d.result = nil
  end
  game.selected_index = nil

  game.turn_state = TURN_TREAT_CHOICE
end

function use_treat()

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

  
  local selected = game.chars[game.selected_index]
  if selected ~= nil then
    local cell = board[selected.pos]
    rect(cell.x, cell.y, cell.x+7, cell.y+7, 7)
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
      [TURN_START] = "start",
      [TURN_TREAT_CHOICE] = "treat choice",
      [TURN_ROLL_DICE] = "roll dice",
      [TURN_SELECT_CHAR] = "select character",
      [TURN_CHOOSE_STEPS] = "choose steps",
      [TURN_MOVE_CHAR] = "move character",
      [TURN_CHECK_CAPTURE] = "check caught",
      [TURN_END] = "turn end"
  }
  print("turn state: "..(turn_states[game.turn_state] or "unknown"), 2, 18, 7)

end
