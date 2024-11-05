local opt = vim.opt

-- 行号
opt.relativenumber = true
opt.number = true

-- 缩进
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- 防止包裹
opt.wrap = false

-- 光标行
opt.cursorline = true
-- 光标列
opt.cursorcolumn = true

-- 启用鼠标
opt.mouse:append("a")

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"
vim.cmd[[colorscheme tokyonight-moon]]


-- 新文件标题
-- 新建.c,.h,.sh,.java文件，自动插入文件头
vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = {"*.cpp", "*.[ch]", "*.sh", "*.rb", "*.java", "*.py"},
	callback = function()
		local filetype = vim.bo.filetype
		local lines = {}
		if filetype == 'sh' then
			table.insert(lines, "#!/bin/bash")
			table.insert(lines, "")
		elseif filetype == 'python' then
			table.insert(lines, "#!/usr/bin/env python")
			table.insert(lines, "# coding=utf-8")
			table.insert(lines, "")
		elseif filetype == 'ruby' then
			table.insert(lines, "#!/usr/bin/env ruby")
			table.insert(lines, "# encoding: utf-8")
			table.insert(lines, "")
        elseif filetype == 'java' then
            table.insert(lines, "/**")
			table.insert(lines, " * @ProjectName: " .. vim.fn.expand("%"))
            table.insert(lines, " * @Author: CN")
            table.insert(lines, " * @Create Time: " .. os.date())
            table.insert(lines, " */")
            table.insert(lines, "")
			table.insert(lines, "public class " .. vim.fn.expand("%:r") .. " {")
			table.insert(lines, "    public static void main(String[] args) {")
            table.insert(lines, "")
            table.insert(lines, "    }")
			table.insert(lines, "}")
		else
			table.insert(lines, "/*************************************************************************")
			table.insert(lines, "    > File Name: " .. vim.fn.expand("%"))
			table.insert(lines, "    > Author: ")
			table.insert(lines, "    > Mail: ")
			table.insert(lines, "    > Created Time: " .. os.date())
			table.insert(lines, " ************************************************************************/")
			table.insert(lines, "")
		end
		if vim.fn.expand("%:e") == 'cpp' then
			table.insert(lines, "#include <iostream>")
			table.insert(lines, "using namespace std;")
			table.insert(lines, "")
		end
		if filetype == 'c' then
			table.insert(lines, "#include <stdio.h>")
			table.insert(lines, "")
		end
		if vim.fn.expand("%:e") == 'h' then
			table.insert(lines, "#ifndef _" .. string.upper(vim.fn.expand("%:r")) .. "_H")
			table.insert(lines, "#define _" .. string.upper(vim.fn.expand("%:r")) .. "_H")
			table.insert(lines, "#endif")
		end
		vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	end
})

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*",
    callback = function()
        vim.cmd("normal G")
        if vim.fn.expand("%:e") == 'java' then
            -- vim.cmd("normal 2k")
            -- vim.api.nvim_win_set_cursor(0, {9, 8})
            -- 获取当前缓冲区
            local buffer = vim.api.nvim_get_current_buf()

            -- 获取第8行的内容
            local line_content = vim.api.nvim_buf_get_lines(buffer, 8, 9, false)[1] or ""

            -- 如果第8行是空行，插入两个 Tab 键
            if line_content == "" then
                local tabs = "\t\t"
                vim.api.nvim_buf_set_lines(buffer, 8, 9, false, {tabs})
            end

            -- 移动光标到第8行，两个 Tab 键处（假设一个 Tab 是 4 个空格）
            vim.api.nvim_win_set_cursor(0, {9, 8})
        end
    end
})
