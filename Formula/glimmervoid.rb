class Glimmervoid < Formula
  desc "Supervise terminal coding agents on a shared whiteboard"
  homepage "https://glimmervoid.dev"
  version "0.57.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.57.1/glimmervoid-aarch64-apple-darwin.tar.xz"
      sha256 "5e401b3e02033d0f8afd2f6b1ab3232b3db2c13802e760a4dbc10f295ca81d30"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.57.1/glimmervoid-x86_64-apple-darwin.tar.xz"
      sha256 "bcee0163cd865d3c1b6d06d71b5ef9b0b6de56daebbff06cbfb1edc9db9a6676"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.57.1/glimmervoid-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4b46276d5b47fdc92e92bdb26391e4df3635471356221b8b3347da8afbb45785"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.57.1/glimmervoid-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "28cecc3cda8dd6a9313cd85faea6996d0296d7cc063c4959e0bea3946b0b3867"
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

  test do
    assert_match version.to_s, shell_output("#{bin}/glimmervoid --version")
  end
end
