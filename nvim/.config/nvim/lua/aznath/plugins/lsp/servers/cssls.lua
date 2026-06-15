return {
  name = "cssls",
  config = {
    filetypes = { "css", "scss", "less" },
    single_file_support = true,
    init_options = { provideFormatter = true },
    settings = {
      css = { lint = { unknownAtRules = "ignore" }, validate = true },
      scss = { lint = { unknownAtRules = "ignore" }, validate = true },
      less = { lint = { unknownAtRules = "ignore" }, validate = true },
    },
  },
}
