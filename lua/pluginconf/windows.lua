require("windows").setup({
   autowidth = {
      enable = false,
      winwidth = 0.5,
      filetype = {
         help = 2,
      },
   },
   ignore = {				--			  |windows.ignore|
      buftype = { "quickfix" },
      filetype = { "NvimTree", "neo-tree", "undotree", "gundo" }
   },
   -- animation = {
   --    enable = true,
   --    duration = 300,
   --    fps = 30,
   --    easing = "in_out_sine"
   -- }
})
