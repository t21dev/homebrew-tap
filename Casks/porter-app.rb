cask "porter-app" do
  arch arm: "aarch64", intel: "x64"

  version "0.8.2"
  sha256 arm:   "5c7d4be40a94a38a817e8023d67e800a3f74ea4066eb245fa5b9bf81cd5fd1c6",
         intel: "fa65a6e5b78e9e3826ab9a43f988319fc6d4b0731efa5d1cca4e26e5b3529c29"

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
