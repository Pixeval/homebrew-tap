cask "pixeval" do
  version "5.0.5"

  on_arm do
    sha256 "71f612385cdf0cabd8198304a930d6096c4c22d63d79cecf95ae101d8afd8133"

    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-macos-arm64.zip"
  end
  on_intel do
    sha256 "a88069e59ed3ab54352d8fc2df3fc5ff61e4539bf5787d8cc57e8e362b1c57bc"

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
