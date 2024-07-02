class TestSplitter < Formula
  desc "Buildkite test splitting client"
  homepage "https://github.com/buildkite/test-splitter"

  version "0.7.1"
  if Hardware::CPU.arm?
    url "https://github.com/buildkite/test-splitter/releases/download/v0.7.1/test-splitter-darwin-arm64"
    sha256 "f67dda69a3e2b15dc5f2d0a6aa5bde71b4b0526b918eaaef9746af57218af4f2"
  else
    url "https://github.com/buildkite/test-splitter/releases/download/v0.7.1/test-splitter-darwin-amd64"
    sha256 "2af04832cb323bd5b10dba4d7334908cf9ceefa185fb0866ebbb90149f17d599"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "test-splitter-darwin-arm64" => "test-splitter"
    else
      bin.install "test-splitter-darwin-amd64" => "test-splitter"
    end
  end

  test do
    system "test-splitter", "--version"
  end
end
