class Tapin < Formula
  desc "An inbox for your AI coding agents. Approve, jump, done."
  homepage "https://github.com/Thevi99/tapin"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Thevi99/tapin/releases/download/v0.2.1/tapin-aarch64-apple-darwin.tar.xz"
      sha256 "2b238e2b90fc37aef74a7bd69b3b23752b8dc631bdcdaa656b02e6d8c1e9f315"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Thevi99/tapin/releases/download/v0.2.1/tapin-x86_64-apple-darwin.tar.xz"
      sha256 "48e68785b593a7525c3d20da21f161a4c18e60be92f2a870ce9f30a10d1284a4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Thevi99/tapin/releases/download/v0.2.1/tapin-aarch64-unknown-linux-musl.tar.xz"
      sha256 "9edc8152df940786c50c1a4841c958bc3fdb84139637ff4173626a0a8c678415"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Thevi99/tapin/releases/download/v0.2.1/tapin-x86_64-unknown-linux-musl.tar.xz"
      sha256 "da2967531365360949fa33285438d148d2e3d62647cf980515fb1b1da8c83d86"
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
