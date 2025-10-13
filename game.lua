current_roll = nil
chosen_critter = nil

function init_game()
    player_turn = 1
    max_position = 0
    init_character()
    init_board()
end

-- update_game: handle turn-based movement
function update_game()
    -- press ❎ to roll spinner
    if btnp(5) then
        local steps = roll_spinner()
        -- for now, move only the first animal
        move_character(animals[player_turn], steps)

        -- move Max one step as a placeholder
        move_character(max, 1)

        -- next player's turn
        player_turn = player_turn + 1
        if player_turn > #animals then
            player_turn = 1
        end

        -- simple win condition: Max reaches end
        if max.pos >= BOARD_SIZE then
            game_state = STATE_END
        end
    end
end

-- draw_game: draw the board and pieces
function draw_game()
    cls()
    -- draw board tiles
    for i=1,BOARD_SIZE do
        rectfill(board[i].x, board[i].y, board[i].x+7, board[i].y+7, 5)
    end

    -- draw animals
    for i,a in ipairs(animals) do
        rectfill(board[a.pos].x+1, board[a.pos].y+1, board[a.pos].x+6, board[a.pos].y+6, a.color)
    end

    -- draw Max
    rectfill(board[max.pos].x+1, board[max.pos].y-6, board[max.pos].x+6, board[max.pos].y-1, max.color)

    -- draw current turn info
    -- print("Turn: "..animals[player_turn].name, 2, 2, 7)
    print("press ❎ to move", 2, 10, 6)
end