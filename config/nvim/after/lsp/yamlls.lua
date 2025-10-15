return {
  settings = {
    yaml = {
      schemas = {
        kubernetes = {
          '/*manifests*/**/*.yaml',
          '/*manifests*/*.yaml',
        },
      }
    },
  },
}
