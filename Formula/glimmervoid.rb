class Glimmervoid < Formula
  desc "See it before it's built. Every terminal coding agent shows its prototypes, architecture and plans on a whiteboard you mark up, and works in its own git worktree. Only the one that needs you asks for your attention."
  homepage "https://glimmervoid.dev"
  version "0.57.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.57.0/glimmervoid-aarch64-apple-darwin.tar.xz"
      sha256 "0f556a12333c8d499112e31cfb035293876d72f88ccda7037a8d6344a202b937"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.57.0/glimmervoid-x86_64-apple-darwin.tar.xz"
      sha256 "87c02382543d8235cfe3fcd3bf6de13ff8d35699ea313d89eb7ac2ac63b9d8c2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.57.0/glimmervoid-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "50e016c308d561081cd503624ffbdf2db4c229e840c27272cc6907982fbef908"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.57.0/glimmervoid-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ffae01e7d947f32bdf1453ce2d6d8ce425a7fa90c548054fee2fd13a67d976e7"
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
