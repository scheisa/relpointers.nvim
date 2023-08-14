local M = {}

-- highlight group
vim.api.nvim_set_hl(0, "RelPointersHl", { underline = true })
local function render_pointers_match(buf_nr, namespace, line_nr)
    vim.fn.matchaddpos("RelPointersHl", { line_nr })

    local line_content = vim.api.nvim_buf_get_lines(buf_nr, line_nr - 1, line_nr, false)
    local pointer_text = line_content[1]

    if pointer_text == "" then
        print("pizda")
        vim.api.nvim_buf_set_extmark(buf_nr, namespace, line_nr - 1, 0,
            { virt_text_pos = "overlay", virt_text = {{"\t\t\t\t\t", "RelPointersHL"}}, virt_text_win_col = 0 })
    end
end

M.start = function(amount, distance)
    amount = amount or 2
    distance = distance or 5

    local buf_nr = vim.api.nvim_get_current_buf()
    local line_nr = vim.fn.line(".")
    local namespace = vim.api.nvim_create_namespace("lines")

    -- clearing
    vim.fn.clearmatches()
    vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)

    -- above cursor line
    local offset_above = line_nr - (distance * amount)
    for i = line_nr - distance, offset_above, -distance do
        if i > 0 then
            render_pointers_match(buf_nr, namespace, i)
        end
    end

    -- below cursor line
    local offset_below = line_nr + (distance * amount)
    for i = line_nr + distance, offset_below, distance do
        if i <= vim.fn.line("$") then
            render_pointers_match(buf_nr, namespace, i)
        end
    end
end

-- autogroup
local group = vim.api.nvim_create_augroup("Relative", { clear = true })
-- autocmd
local id = vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    group = group,
    pattern = "*",

    callback = function()
        M.start(3, 7)
    end
})

-- disable plugin
M.disable = function()
    vim.api.nvim_del_autocmd(id)
    local namespaces = vim.api.nvim_get_namespaces()
    local namespace = namespaces["lines"]
    vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
    vim.fn.clearmatches()
end

return M
