-- player.lua

function make_char(name, start_pos, is_critter)
  return {
    name = name,
    pos = start_pos,       -- current board index
    start_pos = start_pos, -- for resets
    caught = false,
    is_critter = is_critter,
    can_move = false
  }
end

-- move a character forward n steps
function update_move_char()
  move_character(game.selected_index, steps_to_move)
  game.turn_state = TURN_CHECK_CAPTURE
end