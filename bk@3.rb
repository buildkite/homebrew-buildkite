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
      sha256 "effbfe6b6bac2fc14b761c23e6f8d0b25c50d45483226af303f4f149ed242682"

      def install
        bin.install "bk"
      end
    end
    on_arm do
      url "https://github.com/buildkite/cli/releases/download/v3.0.0-beta.20240712/bk_3.0.0-beta.20240712_macOS_arm64.zip"
      sha256 "30a6991cd5c369c7d15997b479fe4a6fcdb6f764ef6e99c2a9c665d4d80aa87f"

      def install
        bin.install "bk"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.0.0-beta.20240712/bk_3.0.0-beta.20240712_linux_amd64.tar.gz"
        sha256 "fce31cde97e5043ab20ad361830bf402c97a3a1305ca5c3c1986b3a24e826393"

        def install
          bin.install "bk"
        end
      end
    end
    on_arm do
      if !Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.0.0-beta.20240712/bk_3.0.0-beta.20240712_linux_armv6.tar.gz"
        sha256 "f0f2a17a365e2b043d51011ab386846a2b719ded6ceb6e7fa975fb48f471a278"

        def install
          bin.install "bk"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/buildkite/cli/releases/download/v3.0.0-beta.20240712/bk_3.0.0-beta.20240712_linux_arm64.tar.gz"
        sha256 "4b6eb0847c68b9385372ae64645788dbcb412f08c91f1aa7e0df0bf2f62e6f8d"

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
