function shallowCopy(o)
    local copy = { }
    for k, v in pairs(o) do
        if type(v) == "table" then
            copy[k] = shallowCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end