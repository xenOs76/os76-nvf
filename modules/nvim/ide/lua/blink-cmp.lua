return {

	{
		"saghen/blink.cmp",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- https://cmp.saghen.dev/modes/cmdline.html#ghost-text
			cmdline = {
				keymap = { preset = "inherit" },
				completion = { menu = { auto_show = true } },
				ghost_text = { enabled = true },
			},
			sources = {
				default = { "lsp", "buffer" },
			},
		},
		opts_extend = { "sources.default" },
	},
}
