return {
  name = "tailwindcss",
  config = {
    filetypes = {
      "html", "css", "javascript", "typescript",
      "javascriptreact", "typescriptreact",
      "svelte", "vue", "astro",
    },
    init_options = {
      userLanguages = { astro = "html" },
    },
  },
}
