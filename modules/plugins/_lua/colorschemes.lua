local hostname = vim.loop.os_gethostname()

local scheme = "tokyonight"
local hosts = {
    oryxpro = "kanagawa-dragon",
    osgiliath = "kanagawa",
    robot_house = "gruvbox",
}

print('hello')
print(vim.env.WORK_MACHINE)
if hosts[hostname] then
    scheme = hosts[hostname]
elseif vim.env.WORK_MACHINE then
    scheme = "base16-solarflare"
end

vim.cmd("colorscheme " .. scheme)
