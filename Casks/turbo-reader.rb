cask "turbo-reader" do
  arch arm: "aarch64", intel: "x64"

  version "0.34.0"
  sha256 arm:   "acc6a144e3777ab846ca8f39f5a87b3c9286ded72b5ce77d09dc107164c62824",
         intel: "93505739e253b8c1d052bc4b83d9c3030a52a386d3ea25896598a79777180731"

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
