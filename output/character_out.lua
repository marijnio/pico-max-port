

function make_char(name, start_pos, is_critter)
  return {
    name = name,
    pos = start_pos,       
    start_pos = start_pos, 
    caught = false,
    is_critter = is_critter,
    can_move = false
  }
end


function update_move_char()
  local selected = get_selected_char()
  if selected == nil then
    game.turn_state = TURN_END
    return
  end

  move_character(game.selected_index, steps_to_move)
  game.turn_state = TURN_RESOLVE_CAPTURE
end
