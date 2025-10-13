

function init_character()
    
    animals = {
        {name="Bunny", pos=3, color=8},
        {name="Fox", pos=3, color=9},
    }
    
    
    max = {pos=1, color=12}
end


function move_character(character, steps)
    character.pos = character.pos + steps
    if character.pos > BOARD_SIZE then
        character.pos = BOARD_SIZE
    end
end