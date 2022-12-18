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

-- Define a helper function to convert a hex color to RGB values
local hex_to_rgb = function (hex)
  -- Extract the R, G, and B values from the hex color
  local r = tonumber(hex:sub(2, 3), 16)
  local g = tonumber(hex:sub(4, 5), 16)
  local b = tonumber(hex:sub(6, 7), 16)

  -- Return the RGB values
  return r, g, b
end

-- Define a helper function to convert RGB values to a hex color
local rgb_to_hex = function (r, g, b)
  -- Convert the RGB values to hex strings
  local r_hex = string.format("%02x", r)
  local g_hex = string.format("%02x", g)
  local b_hex = string.format("%02x", b)

  -- Concatenate the hex strings into a single hex color
  return "#" .. r_hex .. g_hex .. b_hex
end

M.lerp = function(color1, color2, value)
  -- Convert the hex colors to RGB values
  local r1, g1, b1 = hex_to_rgb(color1)
  local r2, g2, b2 = hex_to_rgb(color2)

  -- Perform the linear interpolation for each channel
  local r = r1 + (r2 - r1) * value
  local g = g1 + (g2 - g1) * value
  local b = b1 + (b2 - b1) * value

  -- Convert the interpolated RGB values back to a hex color
  return rgb_to_hex(r, g, b)
end


-- vim.cmd [[ let g:test = synIDattr(synIDtrans(hlID("Normal")), "fg#") ]]

return M
