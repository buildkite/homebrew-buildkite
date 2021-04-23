class TerminalToHtml < Formula
  desc "Converts arbitrary shell output (with ANSI) into beautifully rendered HTML"
  homepage "https://github.com/buildkite/terminal-to-html"

  version "3.6.1"
  if Hardware::CPU.arm?
    url     "https://github.com/buildkite/terminal-to-html/releases/download/v3.6.1/terminal-to-html-3.6.1-darwin-arm64.gz"
    sha256  "667d164e8dbc4f231f61892a23dac18ac7ca2b911d1b60e5b975b762b48e9718"
  else
    url     "https://github.com/buildkite/terminal-to-html/releases/download/v3.6.1/terminal-to-html-3.6.1-darwin-amd64.gz"
    sha256  "45275d2bdd1fa1e9ea730a55435ca4991cd8771d997d353a3d469aa25fcbffce"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "terminal-to-html-#{version}-darwin-arm64" => "terminal-to-html"
    else
      bin.install "terminal-to-html-#{version}-darwin-amd64" => "terminal-to-html"
    end
  end

  test do
    system "#{bin}/terminal-to-html", "--help"
  end
end
