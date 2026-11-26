# frozen_string_literal: true

class Bktec < Formula
  desc "Buildkite Test Engine Client"
  homepage "https://github.com/buildkite/bktest"
  version "3.7.0"

  on_macos do
    on_intel do
      url "https://github.com/buildkite/test-engine-client/releases/download/v3.7.0/bktec_3.7.0_darwin_amd64"
      sha256 "d99e5417ecc7c2896d29a1c899491bf614f5c73635d33d0ad1620763fb0ce1d6"
      def install
        bin.install "bktec_3.7.0_darwin_amd64" => "bktec"
        bin.install_symlink bin/"bktec" => "bktest"
      end
    end
    on_arm do
      url "https://github.com/buildkite/test-engine-client/releases/download/v3.7.0/bktec_3.7.0_darwin_arm64"
      sha256 "d663e9fe83d0be9fa7647d6c882df0cacf03ba1dacf32f573976e15d203af1cf"
      def install
        bin.install "bktec_3.7.0_darwin_arm64" => "bktec"
        bin.install_symlink bin/"bktec" => "bktest"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/buildkite/test-engine-client/releases/download/v3.7.0/bktec_3.7.0_linux_amd64"
      sha256 "a2027f13ce03aa283f6f8564c90a6044242f0828b9786e6f2a036d93f40a9aa3"
      def install
        bin.install "bktec_3.7.0_linux_amd64" => "bktec"
        bin.install_symlink bin/"bktec" => "bktest"
      end
    end
    on_arm do
      url "https://github.com/buildkite/test-engine-client/releases/download/v3.7.0/bktec_3.7.0_linux_arm64"
      sha256 "6854bbdd55b5f7f00095459918647cde74d0d19c3c3d0e5a9924414fe1f0820f"
      def install
        bin.install "bktec_3.7.0_linux_arm64" => "bktec"
        bin.install_symlink bin/"bktec" => "bktest"
      end
    end
  end

  test do
    assert_match "v3.7.0", shell_output("#{bin}/bktec --version")
    assert_match "v3.7.0", shell_output("#{bin}/bktest --version")
  end
end
