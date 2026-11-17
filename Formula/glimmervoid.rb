class Glimmervoid < Formula
  desc "Supervise terminal coding agents on a shared whiteboard"
  homepage "https://glimmervoid.dev"
  version "0.62.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.62.3/glimmervoid-aarch64-apple-darwin.tar.xz"
      sha256 "393e899293a2a505b772d94a2b89247d80841367bd670d7007e36e5a95d7b9af"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.62.3/glimmervoid-x86_64-apple-darwin.tar.xz"
      sha256 "a49da4c0abd1ba1b71d90f4e96b1ce3551ac5ae6789fc0c8690313009788d024"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.62.3/glimmervoid-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c42c5f27472685b54378e3400be0d73a4f3df5248769ada1ba6b11f16129fda0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.62.3/glimmervoid-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "40ecbd0e2167619481730d6b2a15930748c7d8e612e92438fa35dd194213cc14"
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
      bin.install "glimmervoid", "glimmervoid-fnox", "glimmervoid-relay"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "glimmervoid", "glimmervoid-fnox", "glimmervoid-relay"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "glimmervoid", "glimmervoid-fnox", "glimmervoid-relay"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "glimmervoid", "glimmervoid-fnox", "glimmervoid-relay"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/glimmervoid --version")
  end
end
