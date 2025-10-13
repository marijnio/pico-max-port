-- end.lua

function update_end()
    if btnp(4) then
        init_game()
        game_state = STATE_TITLE
    end
end

function draw_end()
    print("game over!", 40, 50, 8)
    print("press 🅾️ to restart", 25, 65, 6)
end