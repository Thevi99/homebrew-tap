class Tapin < Formula
  desc "An inbox for your AI coding agents. Approve, jump, done."
  homepage "https://github.com/Thevi99/tapin"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Thevi99/tapin/releases/download/v0.1.0/tapin-aarch64-apple-darwin.tar.xz"
      sha256 "2a2cfdc529ff40b0ebb79e932e36a3cd323fa553f62bb222cfe27a1c43965961"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Thevi99/tapin/releases/download/v0.1.0/tapin-x86_64-apple-darwin.tar.xz"
      sha256 "bc4f4bbb81887c78e8983729e3e9cb2e96e04d590c65009456710e9b3146c5fd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Thevi99/tapin/releases/download/v0.1.0/tapin-aarch64-unknown-linux-musl.tar.xz"
      sha256 "9faa503670d6abea301778c693ef9bfd876e690999a95106d0ff1c4e7a35c951"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Thevi99/tapin/releases/download/v0.1.0/tapin-x86_64-unknown-linux-musl.tar.xz"
      sha256 "0bfdd46706a594b58e453442334a7e312b11c41736318c613b00367030a301a6"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
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
      bin.install "tapin"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tapin"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "tapin"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tapin"
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
