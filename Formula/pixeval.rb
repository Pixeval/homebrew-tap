class Pixeval < Formula
  desc "Wow. Yet another Pixiv client!"
  homepage "https://pixeval.github.io/"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-macos-arm64.zip"
      sha256 "71f612385cdf0cabd8198304a930d6096c4c22d63d79cecf95ae101d8afd8133"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-macos-x64.zip"
      sha256 "a88069e59ed3ab54352d8fc2df3fc5ff61e4539bf5787d8cc57e8e362b1c57bc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-linux-arm64.tar.gz"
      sha256 "dffdd58fb0a5a4efa3c677c394be6b97ad8e3f4b3c89b3e2087f3e84b2e93164"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-linux-x64.tar.gz"
      sha256 "276268d4093efc39121fcb083964f38f8ac3bec3cc1fda1adca3c2c6eb5452bf"
    end
  end

  def install
    if OS.mac?
      prefix.install "Pixeval.app"
      bin.write_exec_script prefix/"Pixeval.app/Contents/MacOS/Pixeval.Desktop"
    else
      libexec.install Dir["*"]
      bin.write_exec_script libexec/"Pixeval.Desktop"
    end
  end

  test do
    assert_path_exists bin/"Pixeval.Desktop"
  end
end
