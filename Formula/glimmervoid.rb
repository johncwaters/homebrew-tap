class Glimmervoid < Formula
  desc "See it before it's built. Every terminal coding agent shows its prototypes, architecture and plans on a whiteboard you mark up, and works in its own git worktree. Only the one that needs you asks for your attention."
  homepage "https://glimmervoid.dev"
  version "0.55.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.55.0/glimmervoid-aarch64-apple-darwin.tar.xz"
      sha256 "ac8b8c6eb08fd119f2e88fadfd64cd57381f64f9d4b9cccba0077bfe940839b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.55.0/glimmervoid-x86_64-apple-darwin.tar.xz"
      sha256 "314969e6cd20176d0db6e495248cb4b3ce153d7cbf92b041eb9c331e2038f180"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.55.0/glimmervoid-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2c24f9fac18c2bee637f9908de596d41af2ea6ab0347b8dadc9e2f344470321c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.55.0/glimmervoid-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "166eade4a1dd2f7fe97e859e4564731b81e012ede322aee2b4fe89ecb9c6f9b0"
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
