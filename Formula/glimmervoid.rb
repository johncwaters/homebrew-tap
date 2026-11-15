class Glimmervoid < Formula
  desc "Supervise terminal coding agents on a shared whiteboard"
  homepage "https://glimmervoid.dev"
  version "0.61.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.61.1/glimmervoid-aarch64-apple-darwin.tar.xz"
      sha256 "8eb3d592a91d44cecd6b24bcd3704eb5e86534ddcff1cf555191ea104b8aab19"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.61.1/glimmervoid-x86_64-apple-darwin.tar.xz"
      sha256 "aec9ca5ef89d6374fc3671d2ceb3727bb51ccc7e054bbb38b6949669e7681fb3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.61.1/glimmervoid-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "863b86bb9bc40a65c765e63ebcf4c059b686f12a2379d5152e03998748ab8daa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.61.1/glimmervoid-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f1fafef37d914fa370ad35a409300847fcd49f710627964904d6aee43958e190"
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
