cask "pixeval" do
  version "5.0.5"

  on_arm do
    sha256 "049a68d9fc78ff49d85459f6d0d0c6fd1cf7485ae62bb9634d9e8fe05733e466"

    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-macos-arm64.zip"
  end
  on_intel do
    sha256 "8691755f8a44124beee65179cc104fce1c2c086b2f78f4cbc503e187031536d0"

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
