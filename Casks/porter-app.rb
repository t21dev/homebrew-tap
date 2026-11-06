cask "porter-app" do
  version "0.7.0"
  sha256 "38ca03597c6b6c7f6c339d94d00275f2d3d1d9287bd98c2e70374aff94b70f9c"

  url "https://github.com/t21dev/porter-app/releases/download/v#{version}/Porter_#{version}_aarch64.dmg"
  name "Porter"
  desc "Port monitor: see which process holds a port and stop it"
  homepage "https://porter.t21.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  # Releases ship an Apple silicon build only. Add an `arch` block when an Intel dmg exists.
  depends_on arch: :arm64
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
