class TestSplitter < Formula
  desc "Buildkite test splitting client"
  homepage "https://github.com/buildkite/test-splitter"

  version "0.7.3"
  if Hardware::CPU.arm?
    url "https://github.com/buildkite/test-splitter/releases/download/v#{version}/test-splitter-darwin-arm64"
    sha256 "df437cfae7218c436a4ab71ad92cbbf1a00ff20c6f33cfc5fe4ac51c300af08c"
  else
    url "https://github.com/buildkite/test-splitter/releases/download/v#{version}/test-splitter-darwin-amd64"
    sha256 "09c14438b7e44296ea27f8622a65dd62747a959678a9ccc28b2e1a4516da7b2f"
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
    assert_match "v#{version}\n", version_output
  end
end
