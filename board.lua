-- board.lua

-- number of tiles on the board
BOARD_SIZE = 15

function init_board()
    -- simple board as a placeholder
    board = {}
    for i=1,15 do
        board[i] = {x=i*8, y=60}
    end
end