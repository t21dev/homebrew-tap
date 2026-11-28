cask "porter-app" do
  arch arm: "aarch64", intel: "x64"

  version "0.8.4"
  sha256 arm:   "9123eae9073169d5d4904a40634a6e045ee37040f9d2822d07503171841efbc0",
         intel: "cba024f95b69db49e31aee7500347cbfd7f1e271993fb5a30dd686361e1a6fc6"

  url "https://github.com/t21dev/porter-app/releases/download/v#{version}/Porter_#{version}_#{arch}.dmg"
  name "Porter"
  desc "Port monitor: see which process holds a port and stop it"
  homepage "https://porter.t21.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on :macos

  app "Porter.app"
  binary "#{appdir}/Porter.app/Contents/MacOS/porter"

  # The app is not notarised yet. Without this, macOS reports it as damaged.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/Porter.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.triptoafsin.porter",
    "~/Library/Caches/com.triptoafsin.porter",
    "~/Library/Preferences/com.triptoafsin.porter.plist",
    "~/Library/Saved Application State/com.triptoafsin.porter.savedState",
    "~/Library/WebKit/com.triptoafsin.porter",
  ]

  caveats <<~EOS
    Porter is not notarised by Apple yet. This cask clears the quarantine
    flag after install so the app opens normally.

    To stop processes owned by other users, run Porter with sudo.
  EOS
end
