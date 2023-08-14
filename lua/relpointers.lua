local M = {}

local config = {
    amount = 2,
    distance = 5,

    hl_properties = { underline = true },

    enable_autocmd = true,
}

M.setup = function(opts)
    config = vim.tbl_deep_extend("force", config, opts or {})

    if (config.enable_autocmd) then
        -- autogroup
        local group = vim.api.nvim_create_augroup("Relative", { clear = true })
        -- autocmd
        autocmd_id = vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = group,
            pattern = "*",
            callback = M.start,
        })
    end
end

local function render_pointers_match(buf_nr, namespace, line_nr)
    vim.fn.matchaddpos("RelPointersHl", { line_nr })

    local line_content = vim.api.nvim_buf_get_lines(buf_nr, line_nr - 1, line_nr, false)
    local pointer_text = line_content[1]
    print(pointer_text, #pointer_text)
    if (pointer_text == "") then
        vim.api.nvim_buf_set_extmark(buf_nr, namespace, line_nr - 1, 0,
            { virt_text_pos = "overlay", virt_text = { { "\t\t\t\t\t", "RelPointersHL" } }, virt_text_win_col = 0 })
    end
end

M.start = function()
    local amount = config.amount
    local distance = config.distance
    -- highlight group
    vim.api.nvim_set_hl(0, "RelPointersHl", config.hl_properties)

    local buf_nr = vim.api.nvim_get_current_buf()
    local line_nr = vim.fn.line(".")
    local namespace = vim.api.nvim_create_namespace("lines")

    -- clearing
    vim.fn.clearmatches()
    vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)

    -- above cursor line
    local offset_above = line_nr - (distance * amount)
    for i = line_nr - distance, offset_above, -distance do
        if (i > 0) then
            render_pointers_match(buf_nr, namespace, i)
        end
    end

    -- below cursor line
    local offset_below = line_nr + (distance * amount)
    for i = line_nr + distance, offset_below, distance do
        if (i <= vim.fn.line("$")) then
            render_pointers_match(buf_nr, namespace, i)
        end
    end
end

-- disable plugin
M.disable = function()
    vim.api.nvim_del_autocmd(autocmd_id)
    local namespaces = vim.api.nvim_get_namespaces()
    local namespace = namespaces["lines"]
    vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
    vim.fn.clearmatches()
end

return M
