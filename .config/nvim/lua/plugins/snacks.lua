return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      hidden = true,   -- Show dotfiles (hidden files) by default
      ignored = true,  -- Show git-ignored files by default
 
      sources = {
        explorer = {
          hidden = true,   -- Show dotfiles (hidden files) by default
          ignored = true,  -- Show git-ignored files by default
        },
      },
    },
  },
}
