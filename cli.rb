class Cli < Formula
  desc "A command-line tool for working with Buildkite"
  homepage "https://github.com/buildkite/cli"

  version "0.2.0"
  url "https://github.com/buildkite/cli/releases/download/v0.2.0/bk-darwin-amd64-0.2.0"
  sha256 "fd98d21bce1ae8d47bec7b27337ecfb7f7829f99cd155fb532167b53df5e1816"

  def install
    bin.install "bk-darwin-amd64-0.2.0" => "bk"
  end

  def caveats; <<~EOS
    This is experimental! 🦄 🦑

    For any questions, issues of feedback please file an issue: 💖
    https://github.com/buildkite/cli/issues
  EOS
  end

  test do
    system "#{bin}/bk", "--help"
  end
end
