cask "kitab" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.6.1"
  sha256 arm:   "d33478009c640cb1e264b00e0bd078e7b5a3b545914827629651c770fdaaad8c",
         intel: "9be11ce37dd2e2afda6ba38e150fb1486289180a4f9713becf98cfd60abece51"

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
