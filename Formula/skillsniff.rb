class Skillsniff < Formula
  desc "Command-line interface for skillsniff"
  homepage "https://github.com/Haikeysgit/skillsniff"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.0/skillsniff-cli-aarch64-apple-darwin.tar.xz"
      sha256 "38e02a75c915f2c7efee0e5764bf5b83c265317f04cb46a9bf320ef552f7ded2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.0/skillsniff-cli-x86_64-apple-darwin.tar.xz"
      sha256 "ca8809b2e989a3a34697c71813f4607bc1be240e6cee3cde8490ede3dd22700e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.0/skillsniff-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "6021fd1ee70998e999737cd88f7684073673db9c43a4a3b0f36559453c691fe9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Haikeysgit/skillsniff/releases/download/v0.1.0/skillsniff-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "5582c153fa5a99658644a0b27bc6baf24278cc1c0b2d8301aa6fb335df564644"
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
