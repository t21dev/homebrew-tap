cask "dev-cleaner" do
  arch arm: "aarch64", intel: "x64"

  version "0.5.0"
  sha256 arm:   "d10cc73964ff4ddd70ce67743445923a825e2eb6c7839167c7bc3bb13831a545",
         intel: "b9ca7c96e87876710f9e3246f29328589b8021b5e64535b3b82def48307f12f2"

  url "https://github.com/TriptoAfsin/dev-cleaner/releases/download/v#{version}/Dev.Cleaner_#{version}_#{arch}.dmg"
  name "Dev Cleaner"
  desc "Reclaim disk and memory from developer caches, build folders and ports"
  homepage "https://github.com/TriptoAfsin/dev-cleaner"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on :macos

  app "Dev Cleaner.app"

  # Not notarised yet. Without this, macOS reports the app as damaged.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/Dev Cleaner.app"]
  end

  zap trash: [
    "~/Library/Application Support/dev.tripto.dev-cleaner",
    "~/Library/Caches/dev.tripto.dev-cleaner",
    "~/Library/Preferences/dev.tripto.dev-cleaner.plist",
    "~/Library/Saved Application State/dev.tripto.dev-cleaner.savedState",
    "~/Library/WebKit/dev.tripto.dev-cleaner",
  ]

  caveats <<~EOS
    Dev Cleaner is not notarised by Apple yet. This cask clears the quarantine
    flag after install so the app opens normally.
  EOS
end
