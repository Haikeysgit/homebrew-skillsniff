class Skillsniff < Formula
  desc "Command-line interface for skillsniff"
  homepage "https://github.com/Haikeysgit/skillsniff"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.3/skillsniff-cli-aarch64-apple-darwin.tar.xz"
      sha256 "88561cc06e1a5e3290b2fc66c844acf3e371825f5a26a4f2c27252fd829108de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.3/skillsniff-cli-x86_64-apple-darwin.tar.xz"
      sha256 "98f98745e0a634bf35df33a0df10a4ba162025795edbeb4cf9047f0f6c0481b8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.3/skillsniff-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "964d04572a734e5b7c934560e90931307cd8b73d3648f0c5eceae831c82e4e27"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.3/skillsniff-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "8b463dde29a6efab86fc795ad749840e54194fb7c773cb2fe69a442869bee0cf"
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
