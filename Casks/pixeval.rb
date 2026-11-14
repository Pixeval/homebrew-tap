cask "pixeval" do
  arch arm: "arm64", intel: "x64"

  version "5.0.14"
  sha256 arm:          "2d6eef138ff3a701db29bb43f381dc6776ea29d0a02d154aea5dcd46ce9cf11b",
         intel:        "9cc51f80b3590ad51c6b6dea360bfb67cc660a937e49669dec4eff86dc2ebcfa",
         arm64_linux:  "eeb571dff4afaf4bd78aec1ef45a7ee515a2afa2f6566cd60f9808b1cb719efb",
         x86_64_linux: "f93c210e42da467e3899ab7f1e40d4070cb00c5cef3b1f02b037192054a1814d"

  on_macos do
    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-osx-#{arch}-Portable.zip"

    depends_on macos: :monterey

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
