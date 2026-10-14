class Tapin < Formula
  desc "An inbox for your AI coding agents. Approve, jump, done."
  homepage "https://github.com/Thevi99/tapin"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Thevi99/tapin/releases/download/v0.2.0/tapin-aarch64-apple-darwin.tar.xz"
      sha256 "eb511c5625eb11c4cc1549302b2ee8283eb80c664d2cb6aa6301f2cc2a758c24"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Thevi99/tapin/releases/download/v0.2.0/tapin-x86_64-apple-darwin.tar.xz"
      sha256 "0945fa96671c5679ed61c940f50cb39149d668273cceb1b582692c01acb5924f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Thevi99/tapin/releases/download/v0.2.0/tapin-aarch64-unknown-linux-musl.tar.xz"
      sha256 "d61776c8575d4f189705928958b36b6f0f6ff63258558d69f752d7b45daedbee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Thevi99/tapin/releases/download/v0.2.0/tapin-x86_64-unknown-linux-musl.tar.xz"
      sha256 "ed6c8f29a06428573edcac100f488fae336fd73f8a58eeb2936dd331cb76e4c8"
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
