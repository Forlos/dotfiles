local wk = require("which-key")
local mappings = {
    w = {
        name = "window",
        ["/"] = "Split window vertically",
        ["-"] = "Split window horizontally",
        d = "Delte window"
    }
}
local opts = {
    mode = "n", -- NORMAL mode
    -- prefix: use "<leader>f" for example for mapping everything related to finding files
    -- the prefix is prepended to every mapping part of `mappings`
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}
wk.register(mappings, opts)
