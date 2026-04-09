cask "coteditor@beta" do
  version "7.0.0-beta.3"
  sha256 "67a9109da45af0db484ce1e71bdbb72f74427cd34f1b9ed05f0c729dc5c5331f"

  url "https://github.com/coteditor/CotEditor/releases/download/7.0.0-beta.3/CotEditor_7.0.0-beta.3.dmg"
  name "CotEditor"
  desc "Plain-text editor for macOS"
  homepage "https://coteditor.com/"

  app "CotEditor.app"

  postflight do
    wrapper = Pathname.new("#{HOMEBREW_PREFIX}/bin/cot")
    backup  = Pathname.new("#{HOMEBREW_PREFIX}/bin/cot.homebrew-coteditor-beta.bak")

    if wrapper.exist? || wrapper.symlink?
      unless backup.exist?
        FileUtils.mv(wrapper, backup)
      else
        opoo "`#{wrapper}` already exists and backup `#{backup}` is already present; leaving existing command in place."
        next
      end
    end

    File.write(wrapper, <<~SH)
      #!/bin/zsh
      if [ "$#" -eq 0 ]; then
        open -a "CotEditor"
      else
        open -a "CotEditor" "$@"
      fi
    SH

    File.chmod(0o755, wrapper)
  end

  uninstall_postflight do
    wrapper = Pathname.new("#{HOMEBREW_PREFIX}/bin/cot")
    backup  = Pathname.new("#{HOMEBREW_PREFIX}/bin/cot.homebrew-coteditor-beta.bak")

    if wrapper.exist? || wrapper.symlink?
      begin
        contents = File.read(wrapper)
        File.delete(wrapper) if contents.include?('open -a "CotEditor"')
      rescue
      end
    end

    FileUtils.mv(backup, wrapper) if backup.exist? && !wrapper.exist?
  end

  zap trash: [
    "~/Library/Application Support/CotEditor",
    "~/Library/Caches/com.coteditor.CotEditor",
    "~/Library/Preferences/com.coteditor.CotEditor.plist",
    "~/Library/Saved Application State/com.coteditor.CotEditor.savedState",
  ]
end