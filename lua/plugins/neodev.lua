return {
  {
    'saghen/blink.compat',
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = '*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  { -- optional blink completion source for require statements and module annotations
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {},
    opts = {
      fuzzy = { implementation = "prefer_rust_with_warning" },
      signature = {
        enabled = false,
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },
      sources = {
        -- add lazydev to your completion providers
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {},
      },
    },
  }
}
