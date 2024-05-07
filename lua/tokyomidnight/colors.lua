local util = require("tokyomidnight.util")

local M = {}

---@class Palette
M.default = {
  none = "NONE",
  bg_dark = "#1f2335",
  bg = "#24283b",
  bg_highlight = "#292e42",
  terminal_black = "#414868",
  fg = "#c0caf5",
  fg_dark = "#a9b1d6",
  fg_gutter = "#3b4261",
  dark3 = "#545c7e",
  comment = "#565f89",
  dark5 = "#737aa2",
  blue0 = "#3d59a1",
  blue = "#7aa2f7",
  cyan = "#7dcfff",
  blue1 = "#2ac3de",
  blue2 = "#0db9d7",
  blue5 = "#89ddff",
  blue6 = "#b4f9f8",
  blue7 = "#394b70",
  magenta = "#bb9af7",
  magenta2 = "#ff007c",
  purple = "#9d7cd8",
  orange = "#ff9e64",
  yellow = "#e0af68",
  green = "#9ece6a",
  green1 = "#73daca",
  green2 = "#41a6b5",
  teal = "#1abc9c",
  red = "#f7768e",
  red1 = "#db4b4b",
  git = { change = "#6183bb", add = "#449dab", delete = "#914c54" },
  gitSigns = {
    add = "#266d6a",
    change = "#536c9e",
    delete = "#b2555b",
  },
}

M.night = {
  bg = "#1a1b26",
  bg_dark = "#16161e",
}
M.day = M.night

M.moon = function()
  local ret = {
    none = "NONE",
    bg_dark = "#1e2030", --
    bg = "#222436", --
    bg_highlight = "#2f334d", --
    terminal_black = "#444a73", --
    fg = "#c8d3f5", --
    fg_dark = "#828bb8", --
    fg_gutter = "#3b4261",
    dark3 = "#545c7e",
    comment = "#7a88cf", --
    dark5 = "#737aa2",
    blue0 = "#3e68d7", --
    blue = "#82aaff", --
    cyan = "#86e1fc", --
    blue1 = "#65bcff", --
    blue2 = "#0db9d7",
    blue5 = "#89ddff",
    blue6 = "#b4f9f8", --
    blue7 = "#394b70",
    purple = "#fca7ea", --
    magenta2 = "#ff007c",
    magenta = "#c099ff", --
    orange = "#ff966c", --
    yellow = "#ffc777", --
    green = "#c3e88d", --
    green1 = "#4fd6be", --
    green2 = "#41a6b5",
    teal = "#4fd6be", --
    red = "#ff757f", --
    red1 = "#c53b53", --
  }
  ret.comment = util.blend(ret.comment, ret.bg, "bb")
  ret.git = {
    change = util.blend(ret.blue, ret.bg, "ee"),
    add = util.blend(ret.green, ret.bg, "ee"),
    delete = util.blend(ret.red, ret.bg, "dd"),
  }
  ret.gitSigns = {
    change = util.blend(ret.blue, ret.bg, "66"),
    add = util.blend(ret.green, ret.bg, "66"),
    delete = util.blend(ret.red, ret.bg, "aa"),
  }
  return ret
end

---@class Palette
M.midnight = {
  none = "NONE",
  bg_dark = "#070a0e",
  bg = "#090f15",
  bg_highlight = "#1a2533",
  terminal_black = "#475c71",
  fg = "#b5bdc5",
  fg_dark = "#b5bdc5",
  fg_gutter = "#49525a",
  dark3 = "#54697d",
  comment = "#878d96",
  dark5 = "#678aad",
  blue0 = "#5080ff",
  blue = "#78a9ff",
  cyan = "#82cfff",
  blue1 = "#0ab6ba",
  blue2 = "#048e90",
  blue5 = "#50b0e0",
  blue6 = "#9ac6e0",
  blue7 = "#394b70", --default
  magenta = "#a3a0d8",
  magenta2 = "#ff007c", --default
  purple = "#a665d0",
  orange = "#ff9d57",
  yellow = "#c8b670",
  green = "#59a66e",
  green1 = "#8dc9a7",
  green2 = "#4da371",
  teal = "#1aa7bc",
  red = "#ff7279",
  red1 = "#fa4d56",
  git = {
    add = "#42be65",
    change = "#d2a106",
    delete = "#fa4d56",
  },
  gitSigns = {
    add = "#42be65",
    change = "#d2a106",
    delete = "#fa4d56",
  },
}

---@return ColorScheme
function M.setup(opts)
  opts = opts or {}
  local config = require("tokyomidnight.config")

  local style = config.is_day() and config.options.light_style or config.options.style
  local palette = M[style] or {}
  if type(palette) == "function" then
    palette = palette()
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

  util.bg = colors.bg
  util.day_brightness = config.options.day_brightness

  colors.diff = {
    add = util.darken(colors.green2, 0.15),
    delete = util.darken(colors.red1, 0.15),
    change = util.darken(colors.blue7, 0.15),
    text = colors.blue7,
  }

  colors.git.ignore = colors.dark3
  colors.black = util.darken(colors.bg, 0.8, "#000000")
  colors.border_highlight = util.darken(colors.blue1, 0.8)
  colors.border = colors.black

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg_dark

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
    or config.options.styles.sidebars == "dark" and colors.bg_dark
    or colors.bg

  colors.bg_float = config.options.styles.floats == "transparent" and colors.none
    or config.options.styles.floats == "dark" and colors.bg_dark
    or colors.bg

  colors.bg_visual = util.darken(colors.blue0, 0.4)
  colors.bg_search = colors.blue0
  colors.fg_sidebar = colors.fg_dark
  -- colors.fg_float = config.options.styles.floats == "dark" and colors.fg_dark or colors.fg
  colors.fg_float = colors.fg

  colors.error = colors.red1
  colors.todo = colors.blue
  colors.warning = colors.yellow
  colors.info = colors.blue2
  colors.hint = colors.teal

  colors.delta = {
    add = util.darken(colors.green2, 0.45),
    delete = util.darken(colors.red1, 0.45),
  }

  local is_midnight = config.options.style == "midnight"
  if is_midnight then
    colors.diff.add = "#04230a"
    colors.diff.change = "#261d00"
    colors.diff.delete = "#2d0709"
    colors.diff.text = "#483700"

    colors.git.ignore = colors.comment

    colors.border_highlight = colors.fg_gutter

    colors.bg_statusline = colors.bg_highlight

    colors.bg_visual = util.lighten(colors.bg_highlight, 0.9, util.invert_color(colors.bg_dark))
    colors.bg_search = util.darken(colors.blue0, 0.4)

    -- colors.error = "" --default
    colors.todo = "#a6c8ff"
    colors.warning = "#ff9d57"
    colors.info = "#a6c8ff"
    colors.hint = "#adb5bd"

    -- Unused
    -- colors.delta.add =
    -- colors.delta.delete =
  end

  config.options.on_colors(colors)
  if opts.transform and config.is_day() then
    util.invert_colors(colors)
  end

  return colors
end

return M
