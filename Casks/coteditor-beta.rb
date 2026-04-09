cask "coteditor-beta" do
  version "7.0.0-beta.3"
  sha256 "67a9109da45af0db484ce1e71bdbb72f74427cd34f1b9ed05f0c729dc5c5331f"

  url "https://github.com/coteditor/CotEditor/releases/download/7.0.0-beta.3/CotEditor_7.0.0-beta.3.dmg"
  name "CotEditor"
  desc "Lightweight plain-text editor for macOS"
  homepage "https://coteditor.com/"

  app "CotEditor.app"

  zap trash: [
    "~/Library/Application Support/CotEditor",
    "~/Library/Caches/com.coteditor.CotEditor",
    "~/Library/Preferences/com.coteditor.CotEditor.plist",
    "~/Library/Saved Application State/com.coteditor.CotEditor.savedState",
  ]
end