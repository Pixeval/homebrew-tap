class Pixeval < Formula
  desc "Wow. Yet another Pixiv client!"
  homepage "https://pixeval.github.io/"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.7/Pixeval-5.0.7-macos-arm64.zip"
      sha256 "f2c8e948a3befdbaa729de0f4f282711dd995eab9ba4c2e5bd46780ca206e124"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.7/Pixeval-5.0.7-macos-x64.zip"
      sha256 "787ee8f8fb004540a41a8d7cd2dd4230bd928096b21cf8e74ef7f5be087467a5"
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "fontconfig"
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.7/Pixeval-5.0.7-linux-arm64.tar.gz"
      sha256 "e1a5c9d4d50697e1f265704bb56028c797011a379f48f9a9a6d6d91598ca6543"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.7/Pixeval-5.0.7-linux-x64.tar.gz"
      sha256 "e0260e231b17c1be215e3c470b6fb8cd1ad4c65457102991bd76e8b38a85ff85"
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
