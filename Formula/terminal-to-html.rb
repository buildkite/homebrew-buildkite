class TerminalToHtml < Formula
  desc "Converts arbitrary shell output (with ANSI) into beautifully rendered HTML"
  homepage "https://github.com/buildkite/terminal-to-html"

  version "3.17.1"
  if Hardware::CPU.arm?
    url     "https://github.com/buildkite/terminal-to-html/releases/download/v3.17.1/terminal-to-html-3.17.1-darwin-arm64.gz"
    sha256  "264b131fe7ae4601fc8b65e80bdc3d71e5c2cc32853f3a270c9cbaf47b2d45df"
  else
    url     "https://github.com/buildkite/terminal-to-html/releases/download/v3.17.1/terminal-to-html-3.17.1-darwin-amd64.gz"
    sha256  "4350e0e3b1b4dd71b9f4b9d8a197e4946df7be214e1cc1d0f7271135318ccd8d"
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
