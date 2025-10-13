-- board.lua

-- number of tiles on the board
BOARD_SIZE = 10

function init_board()
    -- simple 10-tile board as a placeholder
    board = {}
    for i=1,10 do
        board[i] = {x=i*8, y=60}
    end
end