[
  import_deps: [:phoenix],
  inputs: ["*.{ex,exs,heex}", "{config,lib,test}/**/*.{ex,exs,heex}"],
  plugins: [Phoenix.LiveView.HTMLFormatter]
]
