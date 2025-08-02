local M = {}


-- Determine the path separator based on the OS
-- For POSIX (Linux, macOS), it's '/', for Windows, it's '\'
local sep = package.config:sub(1, 1)

-- Get the user's home directory in a cross-platform way
local home = os.getenv("HOME") or os.getenv("USERPROFILE")

-- Define the path components
local path_parts = { home, ".config", "wezterm", "assets", "bg_blurred.png" }
local mascot_part = { home, ".config", "wezterm", "assets", "terminal-mascot.png" }
local saudi_mascot_path = {home, ".config", "wezterm", "assets", "saudi-terminal-mascot.png"}

-- Concatenate the parts with the correct separator
M.bg_image = table.concat(path_parts, sep)
M.mascot_image = table.concat(mascot_part, sep)
M.saudi_mascot_path = table.concat(saudi_mascot_path, sep)
return M
