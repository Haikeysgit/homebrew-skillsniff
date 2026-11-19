class Skillsniff < Formula
  desc "Command-line interface for skillsniff"
  homepage "https://github.com/Haikeysgit/skillsniff"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.1/skillsniff-cli-aarch64-apple-darwin.tar.xz"
      sha256 "8d4df75276fefb5598825ce64504230d8d040ac581d34400f50c0b2f5929b9af"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.1/skillsniff-cli-x86_64-apple-darwin.tar.xz"
      sha256 "238096002fec697e1884efb32bdc6618920f10ba5a06b069bd4491d58f61fd4d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.1/skillsniff-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "71bdea00067261883caa71e1ac6f3a03ba76f7d1a364b145b1dea7551aae74ec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.1/skillsniff-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "0b0f6e959f772032f1d170b0a4d38b098375458548ccc836ec1bc53129c07027"
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
