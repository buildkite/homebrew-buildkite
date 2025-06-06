# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class BkAT3 < Formula
  desc "Work with Buildkite from the command-line"
  homepage "https://github.com/buildkite/cli"
  version "3.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/buildkite/cli/releases/download/v3.8.0/bk_3.8.0_macOS_amd64.zip"
      sha256 "fc6006e13c4c8ba02a39c33f3f160e46e783b0b4056c926d41b02a756b71246d"

      def install
        bin.install "bk"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/buildkite/cli/releases/download/v3.8.0/bk_3.8.0_macOS_arm64.zip"
      sha256 "c4f6700c63f7bb3730f8a1d288801074fb18ce953abcd49f6cc11fb8936be1bc"

      def install
        bin.install "bk"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.8.0/bk_3.8.0_linux_amd64.tar.gz"
        sha256 "d6b0722692c597e95e271e413e98b7b3d89e588f925d60eac5aa2c9d658f3321"

        def install
          bin.install "bk"
        end
      end
    end
    if Hardware::CPU.arm?
      if !Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.8.0/bk_3.8.0_linux_armv6.tar.gz"
        sha256 "aef808c6573199d3a74636f8ec39510a355ab495befbb8864ae58f83f008b671"

        def install
          bin.install "bk"
        end
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.8.0/bk_3.8.0_linux_arm64.tar.gz"
        sha256 "f0aa097bbce4ea10e59be9b102fde905b72031777a708681da005cf76641e73e"

        def install
          bin.install "bk"
        end
      end
    end
  end

  test do
    system "#{bin}/bk version"
  end
end
