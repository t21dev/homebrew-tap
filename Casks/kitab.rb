cask "kitab" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.1.0"
  sha256 arm:   "8c0c432a148c3b2fd7340e26f5a974e680b6d14835627d975d65895d31749e0c",
         intel: "3cd65a2aadfb723fe9663f331914d0db3160f44d9fe617365b2da060d9519e6e"

  url "https://github.com/t21dev/kitab/releases/download/v#{version}/Kitab_#{version}_#{arch}.dmg"
  name "Kitab Reader"
  desc "Fast, native reader for PDF, ebooks, comics and Markdown"
  homepage "https://github.com/t21dev/kitab"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :monterey

  app "Kitab.app"
  binary "#{appdir}/Kitab.app/Contents/MacOS/kitab"

  # The app is not notarised yet. Without this, macOS reports it as damaged.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/Kitab.app"]
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
