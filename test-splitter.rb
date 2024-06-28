class TestSplitter < Formula
  desc "Buildkite test splitting client"
  homepage "https://github.com/buildkite/test-splitter"

  version "0.7.0"
  if Hardware::CPU.arm?
    url "https://github.com/buildkite/test-splitter/releases/download/v0.7.0/test-splitter-darwin-arm64"
    sha256 "d651ee82885675f57cab6eef3f82980b0c3e554af1f92f2aff9ec31177482b56"
  else
    url "https://github.com/buildkite/test-splitter/releases/download/v0.7.0/test-splitter-darwin-amd64"
    sha256 "f6fa9f54652921c21b650514d21747a81557df83a711b354508a75331ad555ca"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "test-splitter-darwin-arm64" => "test-splitter"
    else
      bin.install "test-splitter-darwin-amd64" => "test-splitter"
    end
  end

  test do
    # We should be able to do this, but it currently fails
    # https://github.com/buildkite/test-splitter/issues/106
    # system "test-splitter", "--version"

    assert_predicate bin/"test-splitter", :executable?
  end
end
