cask "kitab" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.7.1"
  sha256 arm:   "e4d7386505091630241b307c09ef866d80fad30a891e42fd9924c12d635cc48b",
         intel: "89608bf49cef8e9aa5bd2ee139497a4b3b5a3fa476a86fa5fdfbbfef84cf9be0"

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
