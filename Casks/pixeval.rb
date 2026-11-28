cask "pixeval" do
  arch arm: "arm64", intel: "x64"

  version "5.1.1"
  sha256 arm:          "29d25553a52782b2633914b90020ebda4b851d01dec13145e7d1b2a2a4e5e8ff",
         intel:        "cdd2c1834b5c6d6300922242ab3294ee8e462121dc674560eeb13b72e831cfee",
         arm64_linux:  "542d31b6d8773a1968360d31682117b406f8d1a3e9e116af8640e24fee4ee897",
         x86_64_linux: "f45eec4300086bfa4bc0752e977931a55f058d1c7515acd189b59e06103f77fb"

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
