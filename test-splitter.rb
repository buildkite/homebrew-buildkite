class TestSplitter < Formula
  desc "Buildkite test splitting client"
  homepage "https://github.com/buildkite/test-splitter"

  version "0.7.2"
  if Hardware::CPU.arm?
    url "https://github.com/buildkite/test-splitter/releases/download/v0.7.2/test-splitter-darwin-arm64"
    sha256 "7d800fd40ef6dc22c04b0cc373780f5b6b15c3c9f342678fbf7850152121a592"
  else
    url "https://github.com/buildkite/test-splitter/releases/download/v0.7.2/test-splitter-darwin-amd64"
    sha256 "ede9678b2994eb6a7f1b25f5d1650b0c922f94f27f2a0c6b2688606d14dd3f3e"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "test-splitter-darwin-arm64" => "test-splitter"
    else
      bin.install "test-splitter-darwin-amd64" => "test-splitter"
    end
  end

  test do
    version_output = shell_output("test-splitter --version")
    assert_match "v0.7.2\n", version_output
  end
end
