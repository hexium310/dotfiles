return {
  settings = {
    ['rust-analyzer'] = {
      rustfmt = {
        extraArgs = { '+nightly' },
      },
      check = {
        command = 'clippy',
      },
      inlayHints = {
        parameterHints = { enable = false },
      }
    },
  },
}
