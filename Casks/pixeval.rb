cask "pixeval" do
  arch arm: "arm64", intel: "x64"

  version "5.1.0"
  sha256 arm:          "2832fc8bb925c8b2e9cc3682fba3d8a841f1834ef89663458f72d183cf616900",
         intel:        "d49d4d57d69d4d0a0edb98b4059a6353c6a753918b530dcecf0848baef84f48f",
         arm64_linux:  "eb402efcae718be509f6585d3a8d4b57492d0fcbc2fdf868709bbcfe8bc1c27a",
         x86_64_linux: "49dd1405ee405687497865796462f0fe2e971925422830e0128d046f01ecec8f"

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
