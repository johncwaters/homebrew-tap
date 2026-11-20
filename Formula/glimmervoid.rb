class Glimmervoid < Formula
  desc "Supervise terminal coding agents on a shared whiteboard"
  homepage "https://glimmervoid.dev"
  version "0.62.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.62.10/glimmervoid-aarch64-apple-darwin.tar.xz"
      sha256 "695ebcad96d2d4962b7b2bd595188ea7673979a9fa0d01b112f9b0f3aad6020c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.62.10/glimmervoid-x86_64-apple-darwin.tar.xz"
      sha256 "70ff2bc383293c4fa768a8a4be0fc8b73257bb12ba3cf8534027607ba1c6ee5f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.62.10/glimmervoid-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9d2a7f6f78f47a11322782846d7bd68370ee4f69f9c0307294f99dd97364f770"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.62.10/glimmervoid-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "90018aef2c1c43e36308bb1d36d40bc63c3b33ba7fc9ac241318395d47fb91bf"
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

    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"
    target_triple = "#{cpu}-#{os}"
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end

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
