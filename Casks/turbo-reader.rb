cask "turbo-reader" do
  arch arm: "aarch64", intel: "x64"

  version "0.32.0"
  sha256 arm:   "b095e65b7785d98dc2e50e54a35fc2e242981c606d83618b86a88b7cb17cea10",
         intel: "40c63b5d34d3d33b6943e43447f80dd31839fc541cbafa4abbc4255927a5a7c2"

  url "https://github.com/t21dev/turbo-reader/releases/download/v#{version}/Turbo.Reader_#{version}_#{arch}.dmg"
  name "Turbo Reader"
  desc "Fast, small RSS reader with a local agent server"
  homepage "https://turbo-reader.t21.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on :macos

  app "Turbo Reader.app"
  # `turbo-reader --mcp` for Claude Code, Codex and other MCP clients.
  binary "#{appdir}/Turbo Reader.app/Contents/MacOS/turbo-reader"

  # The app is not notarised yet. Without this, macOS reports it as damaged.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/Turbo Reader.app"]
  end

  zap trash: [
    "~/Library/Application Support/dev.t21.turbo-reader",
    "~/Library/Caches/dev.t21.turbo-reader",
    "~/Library/Preferences/dev.t21.turbo-reader.plist",
    "~/Library/Saved Application State/dev.t21.turbo-reader.savedState",
    "~/Library/WebKit/dev.t21.turbo-reader",
  ]

  caveats <<~EOS
    Turbo Reader is not notarised by Apple yet. This cask clears the
    quarantine flag after install so the app opens normally.
  EOS
end
