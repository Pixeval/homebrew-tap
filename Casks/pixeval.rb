cask "pixeval" do
  version "5.0.8"

  on_arm do
    sha256 "f40910d1bbb990cfd473c3f1b911b777379de0f367684a3c570ad59f2d26a877"

    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-macos-arm64.zip"
  end
  on_intel do
    sha256 "29bfd95184acf9486e4c315e4afee95bd1015333df7ffda6de6298a097e243dc"

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
