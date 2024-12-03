# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class BkAT3 < Formula
  desc "Work with Buildkite from the command-line"
  homepage "https://github.com/buildkite/cli"
  version "3.4.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/buildkite/cli/releases/download/v3.4.0/bk_3.4.0_macOS_amd64.zip"
      sha256 "0a913c230c490240276d91d16a4a45c10bd0201e6074dadce6d608f8b3818d40"

      def install
        bin.install "bk"
      end
    end
    on_arm do
      url "https://github.com/buildkite/cli/releases/download/v3.4.0/bk_3.4.0_macOS_arm64.zip"
      sha256 "ff2cdc45e73160d187acc6879d486efe96ddad45a9ac4bc8fda5e505a66fe4cb"

      def install
        bin.install "bk"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.4.0/bk_3.4.0_linux_amd64.tar.gz"
        sha256 "b413989615a86485ba203a488cf11f2a44a2a4751b4e79d425c034e875290126"

        def install
          bin.install "bk"
        end
      end
    end
    on_arm do
      if !Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.4.0/bk_3.4.0_linux_armv6.tar.gz"
        sha256 "d92b2f59936d1463638bbe4212de01ed7d02a0b555fb97ba622948cd6b52dcaa"

        def install
          bin.install "bk"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.4.0/bk_3.4.0_linux_arm64.tar.gz"
        sha256 "787ecfb4eb855ad11ee2d4e225d78880a2f46337e83fda49bec38258b02bc0cb"

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
