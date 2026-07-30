class Pixeval < Formula
  desc "Wow. Yet another Pixiv client!"
  homepage "https://pixeval.github.io/"
  license "GPL-3.0-only"

  head do
    url "https://github.com/Pixeval/Pixeval.git"
  end

  depends_on "dotnet" => :build

  on_macos do
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.5/Pixeval-5.0.5-macos-arm64.zip"
      sha256 "049a68d9fc78ff49d85459f6d0d0c6fd1cf7485ae62bb9634d9e8fe05733e466"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.5/Pixeval-5.0.5-macos-x64.zip"
      sha256 "8691755f8a44124beee65179cc104fce1c2c086b2f78f4cbc503e187031536d0"
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "fontconfig"
    on_arm do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.5/Pixeval-5.0.5-linux-arm64.tar.gz"
      sha256 "05bfee9193ac80d46cfc6f4a8c0cc329077395083a0d0f80b15cb3e4915df971"
    end
    on_intel do
      url "https://github.com/Pixeval/Pixeval/releases/download/5.0.5/Pixeval-5.0.5-linux-x64.tar.gz"
      sha256 "34708701293b719dc2818360063296f4bffad5e777ff7079ce02002603f1fd1f"
    end
  end

  def dotnet_rid
    if OS.mac?
      Hardware::CPU.arm? ? "osx-arm64" : "osx-x64"
    else
      Hardware::CPU.arm? ? "linux-arm64" : "linux-x64"
    end
  end

  def install
    if build.head?
      system "dotnet", "publish",
             "src/Pixeval.Desktop/Pixeval.Desktop.csproj",
             "-c", "Release",
             "-r", dotnet_rid,
             "--self-contained", "true",
             "-o", "publish",
             "-p:DebugSymbols=false",
             "-p:DebugType=None"

      if OS.mac?
        app_dir = buildpath/"Pixeval.app"
        contents = app_dir/"Contents"
        macos_dir = contents/"MacOS"
        resources_dir = contents/"Resources"

        macos_dir.mkpath
        resources_dir.mkpath

        (buildpath/"publish").each_child do |item|
          item.rename macos_dir/item.basename
        end

        icon_src = buildpath/"src/Pixeval.Desktop/Assets/macOS/Pixeval.icns"
        cp icon_src, resources_dir if icon_src.exist?

        executable = macos_dir/"Pixeval.Desktop"
        chmod 0755, executable

        system "plutil", "-create", "xml1", contents/"Info.plist"
        system "plutil", "-insert", "CFBundleDisplayName", "-string", "Pixeval", contents/"Info.plist"
        system "plutil", "-insert", "CFBundleExecutable", "-string", "Pixeval.Desktop", contents/"Info.plist"
        system "plutil", "-insert", "CFBundleIdentifier", "-string", "io.github.pixeval.pixeval", contents/"Info.plist"
        system "plutil", "-insert", "CFBundleName", "-string", "Pixeval", contents/"Info.plist"
        system "plutil", "-insert", "CFBundlePackageType", "-string", "APPL", contents/"Info.plist"
        system "plutil", "-insert", "NSHighResolutionCapable", "-bool", "true", contents/"Info.plist"

        system "codesign", "--force", "--deep", "--sign", "-", "--timestamp=none", app_dir.to_s

        prefix.install app_dir
      else
        libexec.install Dir["publish/*"]

        # Fix RPATH so bundled libs can find Homebrew-installed fontconfig etc.
        [libexec/"libSkiaSharp.so", libexec/"libHarfBuzzSharp.so",
         libexec/"libe_sqlite3.so", libexec/"Pixeval.Desktop"].each do |elf|
          next unless File.exist?(elf)

          old_rpath = Utils.safe_popen_read("patchelf", "--print-rpath", elf).strip
          new_rpath = [old_rpath, (HOMEBREW_PREFIX/"lib").to_s].reject(&:empty?).join(":")
          system "patchelf", "--set-rpath", new_rpath, elf
        end

        bin.write_exec_script libexec/"Pixeval.Desktop"
      end
    elsif OS.mac?
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
