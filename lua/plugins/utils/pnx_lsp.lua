local M = {}

-- Hover that supports responses from multiple language servers.
function M.hover()
    local params = vim.lsp.util.make_position_params()

    vim.lsp.buf_request_all(0, 'textDocument/hover', params, function(responses)
        local sections = {}
        for _, response in pairs(responses) do
            if response.result then
                local result = response.result
                local section = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
                sections = vim.list_extend(sections, { section })
            end
        end

        local markdown_lines = {}
        for i, content in ipairs(sections) do
            markdown_lines = vim.list_extend(markdown_lines, content)
            if i < #sections then
                table.insert(markdown_lines, "---")
            end
        end

        markdown_lines = table.concat(markdown_lines, "\n")
        markdown_lines = vim.split(markdown_lines, "\n", { trimempty = true })
        if vim.tbl_isempty(markdown_lines) then
            return
        end

        vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', {
            focus_id = "lsp_hover"
        })
    end)
end

function M.document_highlight(bufnr)
    local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
    vim.api.nvim_clear_autocmds({
        buffer = bufnr,
        group = group,
    })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })
end

function M.signature_help_on_hover(bufnr)
    local group = vim.api.nvim_create_augroup('lsp_hover', { clear = false })

    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.hover,
    })
end

function M.codelens(augroup, bufnr)
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        group = augroup,
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
    })
end

return M
