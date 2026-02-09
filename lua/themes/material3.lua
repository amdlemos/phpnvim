-- Auto-generated Material 3 theme for NvChad
-- Generated from wallpaper: /home/amdlemos/Pictures/Wallpapers/fabrizio-conti-c3wsMnxQZDw-unsplash.jpg
-- Mode: dark
-- Source color: #0173c8

---@type Base46Table
local M = {}

-- UI Colors from Material 3
M.base_30 = {
  white = "#e0e2ea",
  black = "#101419",
  darker_black = "#101419",
  black2 = "#181c21",
  one_bg = "#1c2025",
  one_bg2 = "#272a30",
  one_bg3 = "#32353b",
  grey = "#414752",
  grey_fg = "#c0c7d4",
  grey_fg2 = "#8a919d",
  light_grey = "#414752",
  
  -- Accent colors
  red = "#ffb4ab",
  baby_pink = "#93000a",
  pink = "#ffb688",
  line = "#8a919d",
  green = "#ffb688",
  vibrant_green = "#b35700",
  nord_blue = "#aec8ef",
  blue = "#a2c9ff",
  seablue = "#0173c8",
  yellow = "#ffb688",
  sun = "#ffdbc7",
  purple = "#aec8ef",
  dark_purple = "#2e4869",
  teal = "#0173c8",
  orange = "#ffb688",
  cyan = "#a2c9ff",
  
  -- UI elements
  statusline_bg = "#1c2025",
  lightbg = "#272a30",
  pmenu_bg = "#a2c9ff",
  folder_bg = "#a2c9ff"
}

-- Syntax highlighting colors (base16 format)
M.base_16 = {
  base00 = "#101419",                    -- Default Background
  base01 = "#1c2025",           -- Lighter Background
  base02 = "#272a30",       -- Selection Background
  base03 = "#8a919d",                    -- Comments, Invisibles
  base04 = "#c0c7d4",           -- Dark Foreground
  base05 = "#e0e2ea",                  -- Default Foreground
  base06 = "#e0e2ea",                  -- Light Foreground
  base07 = "#36393f",              -- Light Background
  base08 = "#ffb4ab",                      -- Variables, Tags
  base09 = "#ffb688",                   -- Integers, Constants
  base0A = "#a2c9ff",                    -- Classes, Search
  base0B = "#ffb688",                   -- Strings
  base0C = "#0173c8",           -- Regex, Escapes
  base0D = "#a2c9ff",                    -- Functions, Methods
  base0E = "#aec8ef",                  -- Keywords, Storage
  base0F = "#93000a"              -- Deprecated
}

-- Optional: Custom highlights
M.polish_hl = {
  defaults = {
    Comment = {
      fg = "#8a919d",
      italic = true,
    },
    LineNr = {
      fg = "#414752",
    },
    CursorLine = {
      bg = "#181c21",
    },
    CursorLineNr = {
      fg = "#a2c9ff",
      bold = true,
    },
    Visual = {
      bg = "#0173c8",
    },
    Pmenu = {
      bg = "#1c2025",
    },
    PmenuSel = {
      bg = "#0173c8",
      fg = "#f4f6ff",
    },
    StatusLine = {
      bg = "#1c2025",
      fg = "#e0e2ea",
    },
    TabLine = {
      bg = "#181c21",
      fg = "#c0c7d4",
    },
    TabLineSel = {
      bg = "#0173c8",
      fg = "#f4f6ff",
    },
    NvimTreeNormal = {
      bg = "#181c21",
    },
    NvimTreeFolderIcon = {
      fg = "#a2c9ff",
    },
  },
  
  treesitter = {
    ["@keyword"] = { fg = "#aec8ef" },
    ["@function"] = { fg = "#a2c9ff" },
    ["@function.builtin"] = { fg = "#0173c8" },
    ["@variable"] = { fg = "#e0e2ea" },
    ["@variable.builtin"] = { fg = "#ffb688" },
    ["@string"] = { fg = "#ffb688" },
    ["@number"] = { fg = "#ffb688" },
    ["@boolean"] = { fg = "#ffb688" },
    ["@constant"] = { fg = "#ffb688" },
    ["@type"] = { fg = "#aec8ef" },
    ["@parameter"] = { fg = "#e0e2ea" },
    ["@property"] = { fg = "#e0e2ea" },
    ["@operator"] = { fg = "#c0c7d4" },
    ["@punctuation"] = { fg = "#414752" },
    ["@comment"] = { 
      fg = "#8a919d", 
      italic = true 
    },
    ["@tag"] = { fg = "#ffb4ab" },
    ["@tag.attribute"] = { fg = "#ffb688" },
    ["@tag.delimiter"] = { fg = "#414752" },
  },

  lsp = {
    DiagnosticError = { fg = "#ffb4ab" },
    DiagnosticWarn = { fg = "#ffb688" },
    DiagnosticInfo = { fg = "#a2c9ff" },
    DiagnosticHint = { fg = "#aec8ef" },
    DiagnosticUnderlineError = { 
      undercurl = true, 
      sp = "#ffb4ab" 
    },
    DiagnosticUnderlineWarn = { 
      undercurl = true, 
      sp = "#ffb688" 
    },
    DiagnosticUnderlineInfo = { 
      undercurl = true, 
      sp = "#a2c9ff" 
    },
    DiagnosticUnderlineHint = { 
      undercurl = true, 
      sp = "#aec8ef" 
    },
  },

  telescope = {
    TelescopePromptBorder = { fg = "#a2c9ff" },
    TelescopeResultsBorder = { fg = "#8a919d" },
    TelescopePreviewBorder = { fg = "#8a919d" },
    TelescopeSelection = { 
      bg = "#0173c8", 
      fg = "#f4f6ff" 
    },
    TelescopeMatching = { fg = "#a2c9ff", bold = true },
  },

  cmp = {
    CmpItemAbbrMatch = { fg = "#a2c9ff", bold = true },
    CmpItemAbbrMatchFuzzy = { fg = "#a2c9ff" },
    CmpItemKindVariable = { fg = "#e0e2ea" },
    CmpItemKindFunction = { fg = "#a2c9ff" },
    CmpItemKindKeyword = { fg = "#aec8ef" },
    CmpItemKindConstant = { fg = "#ffb688" },
    CmpItemKindModule = { fg = "#aec8ef" },
  },

  git = {
    DiffAdd = { fg = "#ffb688" },
    DiffChange = { fg = "#a2c9ff" },
    DiffDelete = { fg = "#ffb4ab" },
    GitSignsAdd = { fg = "#ffb688" },
    GitSignsChange = { fg = "#a2c9ff" },
    GitSignsDelete = { fg = "#ffb4ab" },
  },
}

-- Set theme type based on wallpaper analysis
M.type = "dark"

-- Override theme
M = require("base46").override_theme(M, "material3")

return M
