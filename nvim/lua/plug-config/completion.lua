local cmp = require "cmp"
local compare = require("cmp.config.compare")

cmp.setup {
    completion = {
        completeopt = "menu,menuone,noinsert",
        keyword_length = 1,
        get_trigger_characters = function(trigger_characters)
            return trigger_characters
        end
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm(
            {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true
            }
        )
    }
}
