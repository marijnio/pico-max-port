-- player.lua

function make_char(name, start_pos, is_critter)
  return {
    name = name,
    pos = start_pos,       -- current board index
    start_pos = start_pos, -- for resets
    caught = false,
    is_critter = is_critter
  }
end

-- move a character forward n steps
function move_character(character, steps)
    character.pos = character.pos + steps
    if character.pos > BOARD_SIZE then
        character.pos = BOARD_SIZE
    end
end