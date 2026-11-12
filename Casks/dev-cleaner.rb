cask "dev-cleaner" do
  arch arm: "aarch64", intel: "x64"

  version "0.7.0"
  sha256 arm:   "2c2c1d8f0d4dbfd2f28c3d2120b972d0a577761c1b057059044e0c2c96a2892f",
         intel: "cbda5c0b0ab1ccd184e3ceabd4ca2bdc21f1e92e369fcb68b0675ea05338e492"

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
