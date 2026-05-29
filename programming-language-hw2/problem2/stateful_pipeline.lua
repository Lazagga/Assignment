local data = {3, -1, 4, 0, -2, 5, 8}

local function make_greater_than(threshold)
    return function(value)
        return value > threshold
    end
end

local function make_transformer()
    local count = 0

    local transformer = {}
    transformer.apply = function(value)
        count = count + 1
        return value * 2
    end
    transformer.get_count = function()
        return count
    end

    return transformer
end

local function process(data, predicate, transformer)
    local sum = 0

    for _, value in ipairs(data) do
        if predicate(value) then
            sum = sum + transformer.apply(value)
        end
    end

    return sum
end

local function get_count(transformer)
    return transformer.get_count()
end

local predicate = make_greater_than(2)
local transformer = make_transformer()

local result = process(data, predicate, transformer)
local count = get_count(transformer)

print("result = " .. result)
print("count = " .. count)
