cask "pixeval" do
  version "5.0.9"

  on_arm do
    sha256 "8728353394bb652b100c38e07ebae057c8a3474555a17b98bf48f5e078244c35"

    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-macos-arm64.zip"
  end
  on_intel do
    sha256 "2ebac40bc1d9f61316e37ad09192b00ceaa548ecbfd07c5fbabaf957fb6cf71f"

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
