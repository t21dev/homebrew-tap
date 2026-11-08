# t21dev Homebrew tap

Homebrew casks for apps by [t21 dev](https://t21.dev).

```bash
brew install --cask t21dev/tap/turbo-reader
brew install --cask t21dev/tap/porter-app
brew install --cask t21dev/tap/dev-cleaner
brew install --cask t21dev/tap/kitab
```

| Cask | App | Macs |
| --- | --- | --- |
| `turbo-reader` | [Turbo Reader](https://turbo-reader.t21.dev), a fast, small RSS reader | Apple silicon and Intel |
| `kitab` | [Kitab Reader](https://github.com/t21dev/kitab), a fast, native reader for PDF, ebooks and Markdown | Apple silicon and Intel |
| `porter-app` | [Porter](https://porter.t21.dev), see which process holds a port and stop it | Apple silicon |
| `dev-cleaner` | [Dev Cleaner](https://github.com/TriptoAfsin/dev-cleaner), reclaim disk and memory from developer caches, build folders, AI models and ports | Apple silicon and Intel |

The apps are not notarised by Apple yet, so each cask clears the quarantine
flag after install. Without that, macOS reports the app as damaged.

The Turbo Reader cask also links `turbo-reader` into your PATH, so MCP
clients can run `turbo-reader --mcp`.

## Updates

`.github/workflows/autobump.yml` runs `brew livecheck` every six hours and
opens a pull request when a new GitHub release is out. It needs the secret
`HOMEBREW_BUMP_TOKEN`: a fine-grained token with contents and pull requests
write on this repository.
