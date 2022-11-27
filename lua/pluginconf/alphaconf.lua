local present, alpha = pcall(require, "alpha")

if not present then
   return
end

local ascii = {
"         ██         ",
"██      ████      ██",
"████    ████    ████",
"██ ██    ██    ██ ██",
"██ ██    ██    ██ ██",
"██  ██   ██   ██  ██",
"██  ██   ██   ██  ██",
"██  ██  ████  ██  ██",
"█████   ████   █████",
"██  █  ██  ██  █  ██",
"██  █████  █████  ██",
"██   ██ ████ ██   ██",
"████████████████████",
"     ███ ██ ███     ",
"       ██████       ",
"         ██         ",
}

local ascii_tree = {
[[                 .!,            .!,]],
[[                ~ 6 ~          ~ 6 ~]],
[[           .    ' i `  .-^-.   ' i `]],
[[         _.|,_   | |  / .-. \   | |]],
[[          '|`   .|_|.| (-` ) | .|_|.]],
[[          / \ ___)_(_|__`-'__|__)_(______]],
[[         /`,o\)_______________________o_(]],
[[        /_* ~_\[___]___[___]___[___[_[\`-.]],
[[        / o .'\[_]___[___]___[___]_[___)`-)]],
[[       /_,~' *_\_]                 [_[(  (]],
[[       /`. *  *\_]                 [___\ _\]],
[[      /   `~. o \]      ;( ( ;     [_[_]`-']],
[[     /_ *    `~,_\    (( )( ;(;    [___] ]],
[[     /   o  *  ~'\   /\ /\ /\ /\   [_[_] ]],
[[    / *    .~~'  o\  ||_||_||_||   [___] ]],
[[   /_,.~~'`    *  _\_||_||_||_||___[_[_]_]],
[[   /`~..  o        \:::::::::::::::::::::\]],
[[  / *   `'~..   *   \:::::::::::::::::::::\]],
[[ /_     o    ``~~.,,_\=========\_/=========']],
[[ /  *      *     ..~'\         _|_ .-_--.]],
[[/*    o   _..~~`'*   o\           ( (_)  )]],
[[`-.__.~'`'   *   ___.-'            `----']],
[[      ":-------:"]],
[[        \_____/]],
}

local header = {
   type = "text",
   val = ascii_tree,
   opts = {
      position = "center",
      hl = "AlphaHeader",
   },
}

local function button(sc, txt, keybind)
   local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

   local opts = {
      position = "center",
      text = txt,
      shortcut = sc,
      cursor = 5,
      width = 36,
      align_shortcut = "right",
      hl = "AlphaButtons",
      hl_shortcut = "AlphaButtonsShortcut",
   }

   if keybind then
      opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
   end

   return {
      type = "button",
      val = txt,
      on_press = function()
         local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
         vim.api.nvim_feedkeys(key, "normal", false)
      end,
      opts = opts,
   }
end

local buttons = {
   type = "group",
   val = {
      button(" o ", "  Recent File  ", ":Telescope oldfiles<CR>"),
      button(" f ", "  Find File  ", ":Telescope find_files<CR>"),
      button(" n ", "  New file" , ":ene <BAR> startinsert <CR>"),
      button(" w ", "  Find Word  ", ":Telescope live_grep<CR>"),
      button(" b ", "  Bookmarks  ", ":Telescope marks<CR>"),
--    button("SPC c", "  Colorschemes  ", ":Telescope colorscheme<CR>"),
      -- button("SPC s", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
   },
   opts = {
      spacing = 1,
   },
}

local section = {
   header = header,
   buttons = buttons,
}

alpha.setup {
   layout = {
      { type = "padding", val = 1 },
      section.header,
      { type = "padding", val = 2 },
      section.buttons,
   },
   opts = {},
}
