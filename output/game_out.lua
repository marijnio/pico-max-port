function init_game()
    player_turn = 1
    max_position = 0
    init_character()
    init_board()
end


function update_game()
    
    if btnp(5) then
        local steps = roll_spinner()
        
        move_character(animals[player_turn], steps)

        
        move_character(max, 1)

        
        player_turn = player_turn + 1
        if player_turn > #animals then
            player_turn = 1
        end

        
        if max.pos >= BOARD_SIZE then
            game_state = STATE_END
        end
    end
end


function draw_game()
    cls()
    
    for i=1,BOARD_SIZE do
        rectfill(board[i].x, board[i].y, board[i].x+7, board[i].y+7, 5)
    end

    
    for i,a in ipairs(animals) do
        rectfill(board[a.pos].x+1, board[a.pos].y+1, board[a.pos].x+6, board[a.pos].y+6, a.color)
    end

    
    rectfill(board[max.pos].x+1, board[max.pos].y-6, board[max.pos].x+6, board[max.pos].y-1, max.color)

    
    
    print("press ❎ to move", 2, 10, 6)
end