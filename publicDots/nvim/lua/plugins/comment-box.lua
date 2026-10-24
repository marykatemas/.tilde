return {
  "LudoPinelli/comment-box.nvim",
  config = function()
    require("comment-box").setup({
      -- type of comments:
      --   - "line":  comment-box will always use line style comments
      --   - "block": comment-box will always use block style comments
      --   - "auto":  comment-box will use block line style comments if
      --              multiple lines are selected, line style comments
      --              otherwise
      comment_style = "line",
      doc_width = 80, -- width of the document
      box_width = 60, -- width of the boxes
      borders = { -- symbols used to draw a box
        top = "─",
        bottom = "─",
        left = "│",
        right = "│",
        top_left = "╭",
        top_right = "╮",
        bottom_left = "╰",
        bottom_right = "╯",
      },
      line_width = 70, -- width of the lines
      lines = { -- symbols used to draw a line
        line = "─",
        line_start = "─",
        line_end = "─",
        title_left = "─",
        title_right = "─",
      },
      outer_blank_lines_above = false, -- insert a blank line above the box
      outer_blank_lines_below = false, -- insert a blank line below the box
      inner_blank_lines = false, -- insert a blank line above and below the text
      line_blank_line_above = false, -- insert a blank line above the line
      line_blank_line_below = false, -- insert a blank line below the line
    })

    local wk = require("which-key")

    local mode = { "n", "v" }

    wk.add({
      { "<Leader>cb", group = " □  Boxes", mode = mode },
      { "<Leader>cbb", "<Cmd>CBcabox19<CR>", desc = "Box Title", mode = mode },
      { "<Leader>cbt", "<Cmd>CBllline<CR>", desc = "Titled Line", mode = mode },
      { "<Leader>cbl", "<Cmd>CBline<CR>", desc = "Simple Line", mode = mode },
      { "<Leader>cbm", "<Cmd>CBllbox14<CR>", desc = "Marked", mode = mode },
      { "<Leader>cbd", "<Cmd>CBd<CR>", desc = "Remove a box", mode = mode },
    })
    -- where:
    -- - `CB` is for "Comment-Box"
    -- - `x` is for the position of the box or line (`l`: left, `c`: center, `r`: right)
    -- - `y` is for the text justification (`l`: left, `c`: center, `r`: right). For the box, it can be `a` ("adapted"): the size of the box will be adapted to the size of the text (up to `box_width`)
    -- - `box|line` to choose if it applies to a box or a line
    -- - `[num]` is optional an apply a style from the catalog
  end,
}
