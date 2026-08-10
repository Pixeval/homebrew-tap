class Pixeval < Formula
  desc "Wow. Yet another Pixiv client!"
  homepage "https://pixeval.github.io/"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.8/Pixeval-5.0.8-macos-arm64.zip"
      sha256 "f40910d1bbb990cfd473c3f1b911b777379de0f367684a3c570ad59f2d26a877"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.8/Pixeval-5.0.8-macos-x64.zip"
      sha256 "29bfd95184acf9486e4c315e4afee95bd1015333df7ffda6de6298a097e243dc"
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "fontconfig"
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.8/Pixeval-5.0.8-linux-arm64.tar.gz"
      sha256 "56229d5a90464fc780b59f7eaf84dcd4b987074aef460decb4d362af5f2a4e30"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.8/Pixeval-5.0.8-linux-x64.tar.gz"
      sha256 "5d76b01419e567daa56c193f3e48e6bbc02bd023a871d55776757626766eeb6b"
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
