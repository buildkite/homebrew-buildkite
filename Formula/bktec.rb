# frozen_string_literal: true

class Bktec < Formula
  desc "Buildkite Test Engine Client"
  homepage "https://github.com/buildkite/bktest"
  version "3.6.0"

  on_macos do
    on_intel do
      url "https://github.com/buildkite/test-engine-client/releases/download/v3.6.0/bktec_3.6.0_darwin_amd64"
      sha256 "7b5d9abe57e8f2190ebaed3d7b374ddb0bb89442aaf0f16eb0d131144ad63917"
      def install
        bin.install "bktec_3.6.0_darwin_amd64" => "bktec"
        bin.install_symlink bin/"bktec" => "bktest"
      end
    end
    on_arm do
      url "https://github.com/buildkite/test-engine-client/releases/download/v3.6.0/bktec_3.6.0_darwin_arm64"
      sha256 "a58d3301b7538d9d73bd78ee5a6dceff7485f3d0d4945c3ae458442bd5443d2f"
      def install
        bin.install "bktec_3.6.0_darwin_arm64" => "bktec"
        bin.install_symlink bin/"bktec" => "bktest"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/buildkite/test-engine-client/releases/download/v3.6.0/bktec_3.6.0_linux_amd64"
      sha256 "d630c96e7be9772a46e9731d70b269d6e3fe7f084001de47cc8e91e1dc8227e7"
      def install
        bin.install "bktec_3.6.0_linux_amd64" => "bktec"
        bin.install_symlink bin/"bktec" => "bktest"
      end
    end
    on_arm do
      url "https://github.com/buildkite/test-engine-client/releases/download/v3.6.0/bktec_3.6.0_linux_arm64"
      sha256 "8714adc3d8a2895b6cc2f6ce529ab8d2656fdb947e9bcc445b160bf4b47bbfb7"
      def install
        bin.install "bktec_3.6.0_linux_arm64" => "bktec"
        bin.install_symlink bin/"bktec" => "bktest"
      end
    end
  end

  test do
    assert_match "v3.6.0", shell_output("#{bin}/bktec --version")
    assert_match "v3.6.0", shell_output("#{bin}/bktest --version")
  end
end
