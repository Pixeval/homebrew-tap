class Pixeval < Formula
  desc "Wow. Yet another Pixiv client!"
  homepage "https://pixeval.github.io/"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.6/Pixeval-5.0.6-macos-arm64.zip"
      sha256 "1f545287a6e3a56933be8bbe3af741183714fe53d1eb72ce87b5a6b89352aea0"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.6/Pixeval-5.0.6-macos-x64.zip"
      sha256 "e710d0019eb55fe1a9805fa3b36ce0ab234c7a9b59f57b0c779df5546e87ee94"
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "fontconfig"
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.6/Pixeval-5.0.6-linux-arm64.tar.gz"
      sha256 "8e8ed333f6586a96b8d14e06ebafadc4ef59d234990b9eeda291039dd0cade1d"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.6/Pixeval-5.0.6-linux-x64.tar.gz"
      sha256 "9eea1f1c132574642369147522839e0421c53023ea6c05fd3f19f618ccd3ca45"
    end
  end

  def install
    if OS.mac?
      # Homebrew strips Pixeval.app wrapper during zip staging,
      # leaving Contents/ etc. bare in the staging directory.
      mkdir_p "Pixeval.app"
      Dir["*"].each do |item|
        next if %w[Pixeval.app .brew_home].include?(item)

        mv item, "Pixeval.app"
      end
      prefix.install "Pixeval.app"
    else
      libexec.install Dir["*"]
      # Fix RPATH so bundled libs can find Homebrew-installed fontconfig etc.
      [libexec/"libSkiaSharp.so", libexec/"libHarfBuzzSharp.so",
       libexec/"libe_sqlite3.so", libexec/"Pixeval.Desktop"].each do |elf|
        next unless File.exist?(elf)

        old_rpath = `patchelf --print-rpath #{elf}`.strip
        new_rpath = [old_rpath, (HOMEBREW_PREFIX/"lib").to_s].reject(&:empty?).join(":")
        system "patchelf", "--set-rpath", new_rpath, elf
      end
      bin.write_exec_script libexec/"Pixeval.Desktop"
    end
  end

  test do
    if OS.mac?
      assert_path_exists prefix/"Pixeval.app"
    else
      assert_path_exists bin/"Pixeval.Desktop"
    end
  end
end
