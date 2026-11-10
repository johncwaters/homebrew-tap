class Glimmervoid < Formula
  desc "See it before it's built. Every terminal coding agent shows its prototypes, architecture and plans on a whiteboard you mark up, and works in its own git worktree. Only the one that needs you asks for your attention."
  homepage "https://glimmervoid.dev"
  version "0.56.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.56.0/glimmervoid-aarch64-apple-darwin.tar.xz"
      sha256 "fd794d1030035a2dc4244c4f9ffddb110e30efb44241a9f335a6523e81a1092b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.56.0/glimmervoid-x86_64-apple-darwin.tar.xz"
      sha256 "7276b84efe1fdb3be73852929c33a43eb90800d95a1e71b6ab0f91fa565de6f9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.56.0/glimmervoid-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "416e05725c6750ee5d2fefab81a8c4a1666a6466722237cf2d6797497795d530"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.56.0/glimmervoid-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7253afcecae3817bff9f7f819b5b38910aa3170063105d13f00e5fed9a4ca40d"
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
