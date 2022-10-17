local cmd = vim.cmd

local M = {}

local function isempty(s)
    return s == nil or s == ''
end

M.bg = function(group, col)
    if(isempty(group)) then return end
    if(isempty(col)) then return end
    cmd("highlight! " .. group .. " guibg=" .. col)
end

M.fg = function(group, col)
    if(isempty(group)) then return end
    if(isempty(col)) then return end
    cmd("highlight! " .. group .. " guifg=" .. col)
end

M.hi = function(group, fgcol, bgcol)
    if(isempty(group)) then return end
    if(isempty(fgcol)) then return end
    if(isempty(bgcol)) then return end
    cmd("highlight! " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

M.style = function(group, value)
    if(isempty(group)) then return end
    if(isempty(value)) then return end
    cmd("highlight! " .. group .. " gui=" .. value)
end

M.getFg = function(highlightGroup)
    return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(highlightGroup)), "fg#")
end

M.getBg = function(highlightGroup)
    return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(highlightGroup)), "bg#")
end

M.darker = function(color_value, darker_n)
    local result = "#"
    for s in color_value:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
        local bg_numeric_value = tonumber("0x" .. s) - darker_n
        if bg_numeric_value < 0 then bg_numeric_value = 0 end
        if bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format("%2.2x", bg_numeric_value)
    end
    return result
end

-- vim.cmd [[ let g:test = synIDattr(synIDtrans(hlID("Normal")), "fg#") ]]

return M
