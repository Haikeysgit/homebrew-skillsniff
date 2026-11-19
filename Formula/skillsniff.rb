class Skillsniff < Formula
  desc "Command-line interface for skillsniff"
  homepage "https://github.com/Haikeysgit/skillsniff"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.2/skillsniff-cli-aarch64-apple-darwin.tar.xz"
      sha256 "1439f8f50635362378f0251765685bd4de6e96bfc1290a107cbf5d5cef2a4385"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.2/skillsniff-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4fb9ec7ade067cbdcca58cffd23692d0e0a57b8cf35da4241c65bde57a58eea4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.2/skillsniff-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "033679e06fc610cf8b0bc6aa353d4a4a4bf4049bba72626ff433f673f7acb81f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.2/skillsniff-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "6145e17b2f6e0b11404b39ad69071c4c6398fe671423efb48c3342fa4be68d3a"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "skillsniff"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "skillsniff"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "skillsniff"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "skillsniff"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
