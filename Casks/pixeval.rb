cask "pixeval" do
  version "5.0.11"

  on_arm do
    sha256 "6a44dbb436b8b6291891b4d651da44cea299ab3971754d544d4b5006a3490186"

    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-osx-arm64-Portable.zip"
  end
  on_intel do
    sha256 "3054388efe1e0b64e8f5de17f6b6a071eb4ccc800793a8649cdecf2d4b0e0fa2"

    url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-osx-x64-Portable.zip"
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
