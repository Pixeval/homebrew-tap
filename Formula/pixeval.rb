class Pixeval < Formula
  desc "Wow. Yet another Pixiv client!"
  homepage "https://pixeval.github.io/"
  license "GPL-3.0-only"
  disable! date: "2026-08-22", because: "Pixeval changed their way of artifact distribution for linux"
  
  on_macos do
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.10/Pixeval-5.0.10-macos-arm64.zip"
      sha256 "79aa22de17526b2a8602c4d23ee5a2592e77c1ef133887646d9e5ae9e227caa3"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.10/Pixeval-5.0.10-macos-x64.zip"
      sha256 "83ba78f50daba3c0ac7decacc8f6a2c133dc86b316645086139f02c06f80a057"
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "fontconfig"
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.10/Pixeval-5.0.10-linux-arm64.tar.gz"
      sha256 "30f4da27dcac2b0905ad3a1c3f046645daa3a3fb0a09ba3626b5ab1871817289"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.10/Pixeval-5.0.10-linux-x64.tar.gz"
      sha256 "16f04000d172b0abf53bdf46f5ea34dcfe0a420a14f615ce23cad969cd8e795a"
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
