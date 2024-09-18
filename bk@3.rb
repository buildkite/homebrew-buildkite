# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class BkAT3 < Formula
  desc "Work with Buildkite from the command-line"
  homepage "https://github.com/buildkite/cli"
  version "3.0.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/buildkite/cli/releases/download/v3.0.0/bk_3.0.0_macOS_amd64.zip"
      sha256 "fb4185afee7291d75b9d8fa43b822a637ce72ffe1adccc08a1c0084b0f9d7fa3"

      def install
        bin.install "bk"
      end
    end
    on_arm do
      url "https://github.com/buildkite/cli/releases/download/v3.0.0/bk_3.0.0_macOS_arm64.zip"
      sha256 "5edfd5c7830cfebbe1731c91e80e00a99fc3c5ff656fb471feb0b3ff7b149a7b"

      def install
        bin.install "bk"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.0.0/bk_3.0.0_linux_amd64.tar.gz"
        sha256 "b215d71ecd210acb501cbf7e5683aaf777b27f5afd7655f8729306567765f67a"

        def install
          bin.install "bk"
        end
      end
    end
    on_arm do
      if !Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.0.0/bk_3.0.0_linux_armv6.tar.gz"
        sha256 "2e9d956d224654b68d665a18f9320a1cce4feaf4a0270ce52ca9074de4c293f7"

        def install
          bin.install "bk"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.0.0/bk_3.0.0_linux_arm64.tar.gz"
        sha256 "2a5b78c92ab5c253fd6349e10855fdcda33b323f6092e6cbfaeace4a8f9c2a1d"

        def install
          bin.install "bk"
        end
      end
    end
  end

  def caveats
    <<~EOS
      This is beta software

      For any questions, issues or feedback, please file an issue at https://github.com/buildkite/cli/issues
    EOS
  end

  test do
    system "#{bin}/bk version"
  end
end
