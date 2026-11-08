cask "kitab" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.0"
  sha256 arm:   "3e0ce23559a0f031dad2cd1bf93e5019f8d18c7d3d286892356a130d71619182",
         intel: "e1b2b2d6571d34145a87ca1a6eaefb8942cca729b3d6f040a6198c0407221d14"

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
