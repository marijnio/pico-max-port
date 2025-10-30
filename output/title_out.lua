function update_title()
    if btnp(4) then  
        state = STATE_GAME
    end
end

function draw_title()
    print("max!", 52, 40, 7)
    print("press 🅾️ to start", 30, 60, 6)
end