# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Bktec < Formula
  desc "Buildkite Test Engine Client"
  homepage "https://github.com/buildkite/test-engine-client"
  version "1.3.3"

  on_macos do
    on_intel do
      url "https://github.com/buildkite/test-engine-client/releases/download/v1.3.3/bktec_1.3.3_darwin_amd64"
      sha256 "01ee7fd65cade3e19219563b8460692c7e5eecd859e95cb00931b36fe3777bf8"

      def install
        bin.install "bktec_1.3.3_darwin_amd64" => "bktec"
      end
    end
    on_arm do
      url "https://github.com/buildkite/test-engine-client/releases/download/v1.3.3/bktec_1.3.3_darwin_arm64"
      sha256 "05860f29118e126d05d775b8bcad595f72118f88317c4bdac7a98b0c415ae28c"

      def install
        bin.install "bktec_1.3.3_darwin_arm64" => "bktec"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/test-engine-client/releases/download/v1.3.3/bktec_1.3.3_linux_amd64"
        sha256 "e765bb6f2da255aaf7f1a3db87ef5b44cd413f3ae9142de3bf16efe1c8195e5d"

        def install
          bin.install "bktec_1.3.3_linux_amd64" => "bktec"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/test-engine-client/releases/download/v1.3.3/bktec_1.3.3_linux_arm64"
        sha256 "7aa007072b90c8a37861d6d06f80cee9d0e112bc5384208513f0df176134928e"

        def install
          bin.install "bktec_1.3.3_linux_arm64" => "bktec"
        end
      end
    end
  end

  test do
    version_output = shell_output("bktec --version")
    assert_match "v#{version}\n", version_output
  end
end
