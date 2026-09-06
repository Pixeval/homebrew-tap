cask "pixeval@cn" do
  arch arm: "arm64", intel: "x64"

  version "5.0.12"
  sha256 arm:          "b73e56169217d62eb512d79ee029d9b93d195061d46e75ed4f0daaab1b261baf",
         intel:        "edc09772b1d3b50bbde6052467ea9c989dfd6eb8b08035446352d8355e247ff0",
         arm64_linux:  "f7556e09aa44874120b2d9d1f6de1fb6772e60f6d016b56fe1a83ea274928747",
         x86_64_linux: "8cb6e5610ce6d84cc919fbedb06ba3ba225f94c9786f825165430d189f86f998"

  on_macos do
    url "https://gh-proxy.com/github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-osx-#{arch}-Portable.zip"

    depends_on macos: :ventura

    app "Pixeval.app"

    zap trash: [
      "~/Library/Application Support/Pixeval",
      "~/Library/Caches/Pixeval",
    ]
  end
  on_linux do
    url "https://gh-proxy.com/github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-linux-#{arch}.AppImage"

    app_image "Pixeval-linux-#{arch}.AppImage", target: "Pixeval.AppImage"

    zap trash: "~/.local/share/Pixeval"
  end

  name "Pixeval"
  desc "Wow. Yet another Pixiv client!"
  homepage "https://pixeval.github.io/"

  conflicts_with cask: "pixeval"
end
