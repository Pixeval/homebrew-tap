cask "pixeval" do
  version "5.0.7"

  on_arm do
    sha256 "f2c8e948a3befdbaa729de0f4f282711dd995eab9ba4c2e5bd46780ca206e124"

    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-macos-arm64.zip"
  end
  on_intel do
    sha256 "787ee8f8fb004540a41a8d7cd2dd4230bd928096b21cf8e74ef7f5be087467a5"

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
