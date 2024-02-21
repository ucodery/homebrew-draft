class Kayak < Formula
  version "0.5.0"
  on_macos do
    on_arm do
      url "https://github.com/ucodery/kayak/releases/download/v0.5.0/kayak-aarch64-apple-darwin.tar.xz"
      sha256 "f733a7f47e011ec4f664f0aee02e295ac9e7039ad3610abd7c749583c188d0cc"
    end
    on_intel do
      url "https://github.com/ucodery/kayak/releases/download/v0.5.0/kayak-x86_64-apple-darwin.tar.xz"
      sha256 "45440cf17b08c689e7f36b0b58c8c98c0ed4f1ac1b7972815470f287b1db6eca"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ucodery/kayak/releases/download/v0.5.0/kayak-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "74716db62d6798a47f039fa9753a13084f992ee3b3137cd32e4f4e71eee6ffe5"
    end
  end

  def install
    on_macos do
      on_arm do
        bin.install "kayak"
      end
    end
    on_macos do
      on_intel do
        bin.install "kayak"
      end
    end
    on_linux do
      on_intel do
        bin.install "kayak"
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
