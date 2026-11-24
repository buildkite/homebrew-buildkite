# frozen_string_literal: true

class Bktec < Formula
  desc "Buildkite Test Engine Client"
  homepage "https://github.com/buildkite/bktest"
  version "3.6.1"

  on_macos do
    on_intel do
      url "https://github.com/buildkite/test-engine-client/releases/download/v3.6.1/bktec_3.6.1_darwin_amd64"
      sha256 "4ba1c5368b3b3ad71fd40cadf96f331130227d97686bc60445d4bb77bf4572a2"
      def install
        bin.install "bktec_3.6.1_darwin_amd64" => "bktec"
        bin.install_symlink bin/"bktec" => "bktest"
      end
    end
    on_arm do
      url "https://github.com/buildkite/test-engine-client/releases/download/v3.6.1/bktec_3.6.1_darwin_arm64"
      sha256 "d8fc90fd9522f1f9c9b51a3b90794a07b23382c3a5c5ff0d7634e577e17ed178"
      def install
        bin.install "bktec_3.6.1_darwin_arm64" => "bktec"
        bin.install_symlink bin/"bktec" => "bktest"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/buildkite/test-engine-client/releases/download/v3.6.1/bktec_3.6.1_linux_amd64"
      sha256 "24c5bcec81704b549e42a64e8935bc15ad354204163b0a800a1070ff0c3a4a7c"
      def install
        bin.install "bktec_3.6.1_linux_amd64" => "bktec"
        bin.install_symlink bin/"bktec" => "bktest"
      end
    end
    on_arm do
      url "https://github.com/buildkite/test-engine-client/releases/download/v3.6.1/bktec_3.6.1_linux_arm64"
      sha256 "e6b774f2005a6a389a5781750f3dbcb3583b9cd6afa6ec8cce4e5d89c2013c75"
      def install
        bin.install "bktec_3.6.1_linux_arm64" => "bktec"
        bin.install_symlink bin/"bktec" => "bktest"
      end
    end
  end

  test do
    assert_match "v3.6.1", shell_output("#{bin}/bktec --version")
    assert_match "v3.6.1", shell_output("#{bin}/bktest --version")
  end
end
