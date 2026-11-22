cask "porter-app" do
  arch arm: "aarch64", intel: "x64"

  version "0.8.0"
  sha256 arm:   "1a89938ed6004434cd2f0506d7f178ff4e29c748738be5b001fa1ec9780f5d8b",
         intel: "76b413538bad0fb841df25be0e4265368ad3d11377b2bc34f3d9b4d9a97ad84a"

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
