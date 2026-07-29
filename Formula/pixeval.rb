class Pixeval < Formula
  desc "Wow. Yet another Pixiv client!"
  homepage "https://pixeval.github.io/"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-macos-arm64.zip"
      sha256 "049a68d9fc78ff49d85459f6d0d0c6fd1cf7485ae62bb9634d9e8fe05733e466"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-macos-x64.zip"
      sha256 "8691755f8a44124beee65179cc104fce1c2c086b2f78f4cbc503e187031536d0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-linux-arm64.tar.gz"
      sha256 "05bfee9193ac80d46cfc6f4a8c0cc329077395083a0d0f80b15cb3e4915df971"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/#{version}/Pixeval-#{version}-linux-x64.tar.gz"
      sha256 "34708701293b719dc2818360063296f4bffad5e777ff7079ce02002603f1fd1f"
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
