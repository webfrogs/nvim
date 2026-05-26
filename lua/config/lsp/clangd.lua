return {
  cmd = {
    "clangd",
    "--header-insertion-decorators=false",
    "--clang-tidy",
    "--sort-includes=false",
  },
  filetypes = {
    "c",
    "cpp",
    "objc",
    "objcpp",
    "cuda",
    -- "proto",
  },
}
