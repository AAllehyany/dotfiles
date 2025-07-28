local M = {}


-- Determine the path separator based on the OS
-- For POSIX (Linux, macOS), it's '/', for Windows, it's '\'
local sep = package.config:sub(1, 1)

-- Get the user's home directory in a cross-platform way
local home = os.getenv("HOME") or os.getenv("USERPROFILE")

-- Define the path components
local path_parts = { home, ".config", "wezterm", "assets", "bg_blurred.png" }

-- Concatenate the parts with the correct separator
M.bg_image = table.concat(path_parts, sep)
return M
