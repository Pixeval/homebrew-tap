cask "pixeval" do
  version "5.0.4"

  on_arm do
    sha256 "c4a9c47ae32545b4aa7ec833bf9e79b022af9f5079bc04dda814334fa46f0977"

    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-macos-arm64.zip"
  end
  on_intel do
    sha256 "e4a363dcf17a039fc8c12deb69f910e8b1206da56543957e62262194cd005081"

    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-macos-x64.zip"
  end

  name "Pixeval"
  desc "Wow. Yet another Pixiv client!"
  homepage "https://pixeval.github.io"

  depends_on macos: :ventura

  app "Pixeval.app"

  zap trash: [
    "~/Library/Application Support/Pixeval",
    "~/Library/Caches/Pixeval",
  ]
end
