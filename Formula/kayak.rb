class Kayak < Formula
  desc "You ought to know about your artifact's key-data"
  homepage "https://github.com/ucodery/kayak"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ucodery/kayak/releases/download/v0.7.0/kayak-aarch64-apple-darwin.tar.xz"
      sha256 "eb83ac96cbd19b562c0a325d1636868c21517260788a1efdf003cba64c68828d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ucodery/kayak/releases/download/v0.7.0/kayak-x86_64-apple-darwin.tar.xz"
      sha256 "57fcaeaaf5547194aa3f05a474b3136647417f9e1dd9de75b8c102510fc6702e"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/ucodery/kayak/releases/download/v0.7.0/kayak-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1aa30f74b0f6c0e4140a67b70b5f81e7e9ad6d4672e10279e3143824c86f4df7"
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
