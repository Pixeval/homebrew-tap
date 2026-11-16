cask "pixeval" do
  arch arm: "arm64", intel: "x64"

  version "5.0.15"
  sha256 arm:          "f6bd7f20ba4c6d417f49b9d9219343990dde752fec89dbdd5de376a2aba6a296",
         intel:        "49715d00cccba3e5e5cebd772e62c443e9f611ab1b6852799b8d181533599a6d",
         arm64_linux:  "606a939c0a61c49d327c7820e36dd05e61cfc9fb8995d5b496770d353f4ad48a",
         x86_64_linux: "9643a4afe37f0c7ee63c7268bd545bade848b8ba3b48a256d4bc7308d78f04df"

  on_macos do
    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-osx-#{arch}-Portable.zip"

    depends_on macos: :sonoma

    app "Pixeval.app"

    zap trash: [
      "~/Library/Application Support/Pixeval",
      "~/Library/Caches/Pixeval",
    ]
  end
  on_linux do
    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-linux-#{arch}.AppImage"

    app_image "Pixeval-linux-#{arch}.AppImage", target: "Pixeval.AppImage"

    zap trash: "~/.local/share/Pixeval"
  end

  name "Pixeval"
  desc "Wow. Yet another Pixiv client!"
  homepage "https://pixeval.github.io/"
end
