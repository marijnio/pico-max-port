


function roll_spinner()
    return flr(rnd(2)) + 1
end

function roll_die()
    if rnd(1) < 0.5 then
        return "green"
    else
        return "black"
    end
end

function roll_dice()
    local d1 = roll_die()
    local d2 = roll_die()
    return d1, d2
end