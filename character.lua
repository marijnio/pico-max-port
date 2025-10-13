-- player.lua

function init_character()
    -- example animal and Max setup
    animals = {
        {name="Bunny", pos=3, color=8},
        {name="Fox", pos=3, color=9},
    }
    
    -- Max character
    max = {pos=1, color=12}
end

-- move a character forward n steps
function move_character(character, steps)
    character.pos = character.pos + steps
    if character.pos > BOARD_SIZE then
        character.pos = BOARD_SIZE
    end
end