class Pixeval < Formula
  desc "Wow. Yet another Pixiv client!"
  homepage "https://pixeval.github.io/"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.9/Pixeval-5.0.9-macos-arm64.zip"
      sha256 "8728353394bb652b100c38e07ebae057c8a3474555a17b98bf48f5e078244c35"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.9/Pixeval-5.0.9-macos-x64.zip"
      sha256 "2ebac40bc1d9f61316e37ad09192b00ceaa548ecbfd07c5fbabaf957fb6cf71f"
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "fontconfig"
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.9/Pixeval-5.0.9-linux-arm64.tar.gz"
      sha256 "ac15e62979430a5d64027f4cc849b793e475cd766acea39f8648fbbfd28e2407"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.9/Pixeval-5.0.9-linux-x64.tar.gz"
      sha256 "583ab38c48c7a78c737628b07b58d7281cc2b4bccf85768ad9a5089ace4e561f"
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
