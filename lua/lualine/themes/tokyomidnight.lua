local colors = require("tokyomidnight.colors").setup({ transform = true })
local config = require("tokyomidnight.config").options

local tokyonight = {}

local is_midnight = config.style == "midnight"

if is_midnight then

  local possibly_transparent = config.transparent and colors.none or colors.bg_statusline

  tokyonight.normal = {
    a = { bg = "#013360", fg = colors.fg },
    b = { bg = colors.bg_highlight, fg = colors.fg },
    c = { bg = possibly_transparent, fg = colors.comment },
  }

  tokyonight.insert = {
    a = { bg = "#04350a", fg = colors.fg },
    b = { bg = colors.bg_highlight, fg = colors.fg },
  }

  tokyonight.command = {
    a = { bg = "#6d5403", fg = colors.fg },
    b = { bg = colors.bg_highlight, fg = colors.fg },
  }

  tokyonight.visual = {
    a = { bg = "#4f1d90", fg = colors.fg },
    b = { bg = colors.bg_highlight, fg = colors.fg },
  }

  tokyonight.replace = {
    a = { bg = "#580e10", fg = colors.fg },
    b = { bg = colors.bg_highlight, fg = colors.fg },
  }

  -- tokyonight.terminal = {
  --   a = {bg = colors.green1, fg = colors.black },
  --   b = {bg = colors.fg_gutter, fg = colors.green1 },
  -- }

  tokyonight.inactive = {
    a = { bg = possibly_transparent, fg = colors.comment },
    b = { bg = possibly_transparent, fg = colors.comment },
    c = { bg = possibly_transparent, fg = colors.comment },
  }

else

  tokyonight.normal = {
    a = { bg = colors.blue, fg = colors.black },
    b = { bg = colors.fg_gutter, fg = colors.blue },
    c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },
  }

  tokyonight.insert = {
    a = { bg = colors.green, fg = colors.black },
    b = { bg = colors.fg_gutter, fg = colors.green },
  }

  tokyonight.command = {
    a = { bg = colors.yellow, fg = colors.black },
    b = { bg = colors.fg_gutter, fg = colors.yellow },
  }

  tokyonight.visual = {
    a = { bg = colors.magenta, fg = colors.black },
    b = { bg = colors.fg_gutter, fg = colors.magenta },
  }

  tokyonight.replace = {
    a = { bg = colors.red, fg = colors.black },
    b = { bg = colors.fg_gutter, fg = colors.red },
  }

  tokyonight.terminal = {
    a = {bg = colors.green1, fg = colors.black },
    b = {bg = colors.fg_gutter, fg = colors.green1 },
  }

  tokyonight.inactive = {
    a = { bg = colors.bg_statusline, fg = colors.blue },
    b = { bg = colors.bg_statusline, fg = colors.fg_gutter, gui = "bold" },
    c = { bg = colors.bg_statusline, fg = colors.fg_gutter },
  }

end

if config.lualine_bold then
  for _, mode in pairs(tokyonight) do
    mode.a.gui = "bold"
  end
end

return tokyonight
