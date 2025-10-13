STATE_TITLE = 0
STATE_GAME = 1
STATE_END = 2

game_state = STATE_TITLE

function update_state()
    if game_state == STATE_TITLE then
        update_title()
    elseif game_state == STATE_GAME then
        update_game()
    elseif game_state == STATE_END then
        update_end()
    end
end

function draw_state()
    cls()
    if game_state == STATE_TITLE then
        draw_title()
    elseif game_state == STATE_GAME then
        draw_game()
    elseif game_state == STATE_END then
        draw_end()
    end
end

-- main initialization
function _init()
    init_game()
end

-- main update loop
function _update()
    update_state()
end

-- main draw loop
function _draw()
    draw_state()
end