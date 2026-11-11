cask "dev-cleaner" do
  arch arm: "aarch64", intel: "x64"

  version "0.6.0"
  sha256 arm:   "516de0d757de86299db8fb4de7bcd1274155837756a51ba095e1a0c677ef0a52",
         intel: "4b1c4ed73df30c044ed4ab44dd2646921c3cad9e80dcc3fd7fd4494c33850843"

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
