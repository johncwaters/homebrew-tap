class Glimmervoid < Formula
  desc "Supervise terminal coding agents on a shared whiteboard"
  homepage "https://glimmervoid.dev"
  version "0.58.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.58.2/glimmervoid-aarch64-apple-darwin.tar.xz"
      sha256 "c8691bbbaf67e14d70e1cfb87c24f4247dde4c4ba76f56ec4113b8028629b02c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.58.2/glimmervoid-x86_64-apple-darwin.tar.xz"
      sha256 "77150f3704bcd3e51c6bab448c70ef1e3b2e23a87e6834b470ecb11f725fa4e9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.58.2/glimmervoid-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8f7a205a8d1b73403ac88793de99c9d93b6133c9a42e8780a74abb8909e962d4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johncwaters/glimmervoid/releases/download/v0.58.2/glimmervoid-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5a272012ea9f79affb9a9da33c4b117392dd064869493642159d496d7ce6259f"
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
