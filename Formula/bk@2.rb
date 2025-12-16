class BkAT2 < Formula
  desc "A command-line tool for working with Buildkite"
  homepage "https://github.com/buildkite/cli"

  disable! date: "2025-12-16", because: "is no longer maintained, use bk@3 instead"

  version "2.0.0"
  if Hardware::CPU.arm?
    url "https://github.com/buildkite/cli/releases/download/v2.0.0/cli-darwin-arm64"
    sha256 "6685371f404b85ce278da138f8f89969da1825d9d4016c6907a3a5e1d118d330"
  else
    url "https://github.com/buildkite/cli/releases/download/v2.0.0/cli-darwin-amd64"
    sha256 "34e387f5bf15c6435ec7f2ae0a844a609c9eb1b997c4790a57bb494f93a8f3fd"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "cli-darwin-arm64" => "bk@2"
    else
      bin.install "cli-darwin-amd64" => "bk@2"
    end
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
