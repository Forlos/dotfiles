-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/forlos/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/forlos/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/forlos/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/forlos/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/forlos/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["cheatsheet.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/cheatsheet.nvim"
  },
  ["dashboard-nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
  },
  ["format.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/format.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  kommentary = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lsp-rooter.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/lsp-rooter.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp-trouble.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/lsp-trouble.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  neogit = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/neogit"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lightbulb"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-reload"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/nvim-reload"
  },
  ["nvim-toggleterm.lua"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  nvim_utils = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/nvim_utils"
  },
  ["orgmode.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\forgmode\frequire\0" },
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/orgmode.nvim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/rust-tools.nvim"
  },
  ["startuptime.vim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/startuptime.vim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  },
  ["zen-mode.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rzen-mode\frequire\0" },
    loaded = true,
    path = "/home/forlos/.local/share/nvim/site/pack/packer/start/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: zen-mode.nvim
time([[Config for zen-mode.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rzen-mode\frequire\0", "config", "zen-mode.nvim")
time([[Config for zen-mode.nvim]], false)
-- Config for: orgmode.nvim
time([[Config for orgmode.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\forgmode\frequire\0", "config", "orgmode.nvim")
time([[Config for orgmode.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: ".v:exception | echom "Please check your config for correctness" | echohl None')
end
