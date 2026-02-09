

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


function move_character(character, steps)
    character.pos = character.pos + steps
    if character.pos > BOARD_SIZE then
        character.pos = BOARD_SIZE
    end
end