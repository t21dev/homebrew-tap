cask "porter-app" do
  arch arm: "aarch64", intel: "x64"

  version "0.8.1"
  sha256 arm:   "9eada3adb903abd10c1fed0976220da9012959052620c2296c125c3d8627cc40",
         intel: "09b855464d643da476f144f9750b366d0e505215d3b85fd48a9c7ecbe0a2c9ad"

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
