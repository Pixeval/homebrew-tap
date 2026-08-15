cask "pixeval" do
  version "5.0.10"

  on_arm do
    sha256 "79aa22de17526b2a8602c4d23ee5a2592e77c1ef133887646d9e5ae9e227caa3"

    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-macos-arm64.zip"
  end
  on_intel do
    sha256 "83ba78f50daba3c0ac7decacc8f6a2c133dc86b316645086139f02c06f80a057"

    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-macos-x64.zip"
  end

  name "Pixeval"
  desc "Wow. Yet another Pixiv client!"
  homepage "https://pixeval.github.io/"

  depends_on macos: :ventura

  app "Pixeval.app"

  zap trash: [
    "~/Library/Application Support/Pixeval",
    "~/Library/Caches/Pixeval",
  ]
end
