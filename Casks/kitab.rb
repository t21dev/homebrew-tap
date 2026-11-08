cask "kitab" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.3.1"
  sha256 arm:   "23f7fb6bec089182e7726a8f9a1d0679be22eaa7751707b74b9e65785ae3046d",
         intel: "17c7cc4c08030189eccf903cf905c5b2d38839263d509989c1ee6694dc437f0a"

  url "https://github.com/t21dev/kitab/releases/download/v#{version}/Kitab_#{version}_#{arch}.dmg"
  name "Kitab Reader"
  desc "Fast, native reader for PDF, ebooks, comics and Markdown"
  homepage "https://github.com/t21dev/kitab"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on :macos

  app "Kitab.app"
  binary "#{appdir}/Kitab.app/Contents/MacOS/kitab"

  # The app is not notarised yet. Without this, macOS reports it as damaged.
  postflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{appdir}/Kitab.app"]
  end

  zap trash: [
    "~/Library/Application Support/dev.t21.kitab",
    "~/Library/Caches/dev.t21.kitab",
    "~/Library/Preferences/dev.t21.kitab.plist",
    "~/Library/Saved Application State/dev.t21.kitab.savedState",
  ]

  caveats <<~EOS
    Kitab Reader is not notarised by Apple yet. This cask clears the
    quarantine flag after install so the app opens normally.
  EOS
end
