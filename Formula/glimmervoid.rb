class Glimmervoid < Formula
  desc "Supervise terminal coding agents on a shared whiteboard"
  homepage "https://glimmervoid.dev"
  version "0.59.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.59.0/glimmervoid-aarch64-apple-darwin.tar.xz"
      sha256 "3fdc0758d6b40380f6725ce49c3220cd9c7e78eb209ff53be945e6baeddf6bad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.59.0/glimmervoid-x86_64-apple-darwin.tar.xz"
      sha256 "465a6185ac0a20ad92dd43dc625ae31740bcb648f1013552c98002293197ab1e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.59.0/glimmervoid-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6c44c75df6d929037e15aff19a4d92157c669f550ebf2134831e6c15e9e6db7d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.59.0/glimmervoid-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b05cdd87eec2b630fad10571c5f6dee49db480adf50720714183fde95d0e0b61"
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
      bin.install "glimmervoid", "glimmervoid-fnox"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "glimmervoid", "glimmervoid-fnox"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "glimmervoid", "glimmervoid-fnox"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "glimmervoid", "glimmervoid-fnox"
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
