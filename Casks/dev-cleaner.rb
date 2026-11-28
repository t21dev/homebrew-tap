cask "dev-cleaner" do
  arch arm: "aarch64", intel: "x64"

  version "0.7.1"
  sha256 arm:   "e22b4ba546e438fe3bbc4786cbc7f925237b04e57b671833ca29126eb75cd95b",
         intel: "7098358e2cbbe5247c321cda0f490b55288112a12497876cd44a06554bd81437"

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
