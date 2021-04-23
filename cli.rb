class Cli < Formula
  desc "A command-line tool for working with Buildkite"
  homepage "https://github.com/buildkite/cli"

  version "1.1.0"
  url "https://github.com/buildkite/cli/releases/download/v1.1.0/bk-darwin-amd64-1.1.0"
  sha256 "580e595c67be43d95ecfd4525c0d0070ea85e8d288370af56ae6d3163c5164f3"

  def install
    bin.install "bk-darwin-amd64-1.1.0" => "bk"
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
