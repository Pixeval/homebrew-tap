cask "pixeval" do
  arch arm: "arm64", intel: "x64"

  version "5.0.13"
  sha256 arm:          "86565bfc6b2345393ecb2698ddb7b730a5e7cc4b0d9f56856a6eada4173a6310",
         intel:        "9ac42fa68a786db9a2997cb809b233476165d62dc0a65ec22dec353056bdf05b",
         arm64_linux:  "65845781d1448a55642b42e95f8d88f09b56e8c575169b67355872b08d69bd19",
         x86_64_linux: "9ab94160ff22edb24e563c4f8d62aa1e8917078a3426d4d75f85c198bfd4b13f"

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
