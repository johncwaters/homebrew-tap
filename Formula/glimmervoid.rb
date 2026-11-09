class Glimmervoid < Formula
  desc "See it before it's built. Every terminal coding agent shows its prototypes, architecture and plans on a whiteboard you mark up, and works in its own git worktree. Only the one that needs you asks for your attention."
  homepage "https://glimmervoid.dev"
  version "0.54.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.54.0/glimmervoid-aarch64-apple-darwin.tar.xz"
      sha256 "708454eb7f7bc9decdbfc35022b22cd7044b7c5023a16345248e479b7a305d9b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.54.0/glimmervoid-x86_64-apple-darwin.tar.xz"
      sha256 "91911a90c0b55db907c440f9c3f84e0de0b5c35657c64585eabd0df02f939813"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.54.0/glimmervoid-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ef17fca5029333492956dbb72e138a066a8c6fed0b5cd3dbe5b342a5e7961ec4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.54.0/glimmervoid-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "20a9a090e6192dd5c0296d3f2c3274893cda0db6a983d99e6a7cffb64345d320"
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
