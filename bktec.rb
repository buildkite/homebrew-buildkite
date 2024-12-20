# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Bktec < Formula
  desc "Buildkite Test Engine Client"
  homepage "https://github.com/buildkite/test-engine-client"
  version "1.3.0"

  on_macos do
    on_intel do
      url "https://github.com/buildkite/test-engine-client/releases/download/v1.3.0/bktec_1.3.0_darwin_amd64"
      sha256 "60cc086f14f1be3d5fe4903a2feea420123a57cb01d9ad04b77d16f9dfa7c55d"

      def install
        bin.install "bktec_1.3.0_darwin_amd64" => "bktec"
      end
    end
    on_arm do
      url "https://github.com/buildkite/test-engine-client/releases/download/v1.3.0/bktec_1.3.0_darwin_arm64"
      sha256 "3d4e6ef51984d87fe96799caf489fab9b19fe9bb1e04aa9f96d19a343ddda44a"

      def install
        bin.install "bktec_1.3.0_darwin_arm64" => "bktec"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/test-engine-client/releases/download/v1.3.0/bktec_1.3.0_linux_amd64"
        sha256 "8c20a16e6eec88d076719e317c38bb7d0c2efd616814236047d7e0d3b9e95ee7"

        def install
          bin.install "bktec_1.3.0_linux_amd64" => "bktec"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/test-engine-client/releases/download/v1.3.0/bktec_1.3.0_linux_arm64"
        sha256 "d9b7586e97d1af1d3b691557a467cb084faff24978c5022ce2df32b4486c80ad"

        def install
          bin.install "bktec_1.3.0_linux_arm64" => "bktec"
        end
      end
    end
  end

  test do
    version_output = shell_output("bktec --version")
    assert_match "v#{version}\n", version_output
  end
end
