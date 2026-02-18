

TILE_SIZE = 8
BOARD_MAIN_SIZE = 25

function build_board_path(start_x, start_y, segments)
    local path = {}
    local x = start_x
    local y = start_y

    add(path, {x=x, y=y})

    for segment in all(segments) do
        for i=1,segment.len do
            x += segment.dx * TILE_SIZE
            y += segment.dy * TILE_SIZE
            add(path, {x=x, y=y})
        end
    end

    if #path ~= BOARD_MAIN_SIZE then
        printh("board path size mismatch: "..#path.." (expected "..BOARD_MAIN_SIZE..")")
    end

    return path
end

function init_board()
    
    local segments = {
        {dx=1,  dy=0, len=8}, 
        {dx=0,  dy=1, len=3}, 
        {dx=-1, dy=0, len=8}, 
        {dx=0,  dy=1, len=3}, 
        {dx=1,  dy=0, len=2}  
    }
    board = build_board_path(20, 40, segments)

    
    critter_end_tiles = {
        mouse = {
            {x=44, y=88},
            {x=52, y=88}
        },
        bird = {
            {x=44, y=96},
            {x=52, y=96}
        },
        squirrel = {
            {x=44, y=104},
            {x=52, y=104}
        }
    }
end
