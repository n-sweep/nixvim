local hostname = vim.loop.os_gethostname()

local schemes = {
  oryxpro = "kanagawa-dragon",
  osgiliath = "kanagawa",
  robot_house = "gruvbox",
  LWV4JGTWHV = "base16-solarflare",
  FG4W0FN64X = "base16-solarflare"

}

local scheme = schemes[hostname] or "tokyonight"

vim.cmd("colorscheme " .. scheme)
