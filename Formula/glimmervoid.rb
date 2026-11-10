class Glimmervoid < Formula
  desc "See it before it's built. Every terminal coding agent shows its prototypes, architecture and plans on a whiteboard you mark up, and works in its own git worktree. Only the one that needs you asks for your attention."
  homepage "https://glimmervoid.dev"
  version "0.56.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.56.1/glimmervoid-aarch64-apple-darwin.tar.xz"
      sha256 "c398c2b71caee67a520ebf409910c522b106653e1163f96f9314494d81b7e9f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.56.1/glimmervoid-x86_64-apple-darwin.tar.xz"
      sha256 "365b1b990381bb05669233aa672095b9f58a2f9873542d8ce1af89c1ac9819bc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.56.1/glimmervoid-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1339d59aa583f5a60ffa49d7b1a4e6e287ea04a1d1e730d5b354fa1690c497fd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.56.1/glimmervoid-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "11e8b247b922fc75d00c6fb65f3d032cf0374befee5d6efd34f41b562add9f33"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "glimmervoid"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "glimmervoid"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "glimmervoid"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "glimmervoid"
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
