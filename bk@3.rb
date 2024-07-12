# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class BkAT3 < Formula
  desc "Work with Buildkite from the command-line"
  homepage "https://github.com/buildkite/cli"
  version "3.0.0-beta.20240712"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/buildkite/cli/releases/download/v3.0.0-beta.20240712/bk_3.0.0-beta.20240712_macOS_amd64.zip"
      sha256 "d7f7d3562640acfb699e1654558d2568f46a588a45a43f0fc4075dc0f964b44e"

      def install
        bin.install "bk"
      end
    end
    on_arm do
      url "https://github.com/buildkite/cli/releases/download/v3.0.0-beta.20240712/bk_3.0.0-beta.20240712_macOS_arm64.zip"
      sha256 "d6549c2511e0e6c4925e07ec2e20b1586b3cfd8235ea4f9d6e9427475ae20d54"

      def install
        bin.install "bk"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.0.0-beta.20240712/bk_3.0.0-beta.20240712_linux_amd64.tar.gz"
        sha256 "98664b2487369c4a18a50239dd3057e38655265c48ad41cf0b4a24cbb67d14d6"

        def install
          bin.install "bk"
        end
      end
    end
    on_arm do
      if !Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.0.0-beta.20240712/bk_3.0.0-beta.20240712_linux_armv6.tar.gz"
        sha256 "738dfde835dd1835f2faa8af21cf4eb6b79486bc3a1fe2df4e7cb3055d503709"

        def install
          bin.install "bk"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.0.0-beta.20240712/bk_3.0.0-beta.20240712_linux_arm64.tar.gz"
        sha256 "a3b68c6e31cc6c1c15e3e0beb0765fd18972c46abc55a3e3ab33407b6058f7e5"

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
