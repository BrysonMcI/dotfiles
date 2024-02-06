local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

local config = {}
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

--- Platform agnostic appearance
config.color_scheme = 'Kanagawa (Gogh)'
-- config.color_scheme = 'Vs Code Dark+ (Gogh)'
-- config.color_scheme = 'Srcery (Gogh)'
-- config.color_scheme = 'Predawn (Gogh)' 
-- config.color_scheme = 'Everblush'
-- config.color_scheme = 'Arthur'
config.window_decorations = "RESIZE"
config.font = wezterm.font('JetBrains Mono')
config.font_size = 10
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    --- Userful windows information
    local success, stdout, stderr = wezterm.run_child_process { 'cmd.exe', 'ver' }
    local major, minor, build, rev = stdout:match("Version ([0-9]+)%.([0-9]+)%.([0-9]+)%.([0-9]+)")
    local is_windows_11 = tonumber(build) >= 22000

    --- Switch to powershell
    config.default_prog = { 'pwsh.exe', '-NoLogo' }
end

return config
