class Kayak < Formula
  desc "You ought to know about your artifact's key-data"
  homepage "https://github.com/ucodery/kayak"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ucodery/kayak/releases/download/v0.6.0/kayak-aarch64-apple-darwin.tar.xz"
      sha256 "aa246304643681c9c3308054c4df6107b2483fb4fd25db6a23a2f365b743d2a3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ucodery/kayak/releases/download/v0.6.0/kayak-x86_64-apple-darwin.tar.xz"
      sha256 "03ef4c391cdf8dc7779738bbcdbc8ca6fe93e40c832fb9621250ca2c29783ed7"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/ucodery/kayak/releases/download/v0.6.0/kayak-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9e0ae951a0fcacf01b906fb5a8a189e46ddd48ef23d9528cdabeb6014b0664f3"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

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
      bin.install "kayak"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kayak"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kayak"
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
