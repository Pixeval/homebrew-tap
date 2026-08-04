cask "pixeval" do
  version "5.0.6"

  on_arm do
    sha256 "1f545287a6e3a56933be8bbe3af741183714fe53d1eb72ce87b5a6b89352aea0"

    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-macos-arm64.zip"
  end
  on_intel do
    sha256 "e710d0019eb55fe1a9805fa3b36ce0ab234c7a9b59f57b0c779df5546e87ee94"

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
