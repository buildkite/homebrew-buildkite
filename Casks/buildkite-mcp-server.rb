# This file was generated by GoReleaser. DO NOT EDIT.
cask "buildkite-mcp-server" do
  desc "Model Context Protocol server for Buildkite"
  homepage "https://github.com/buildkite/buildkite-mcp-server"
  version "0.5.5"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "buildkite-mcp-server"

  on_macos do
    on_intel do
      url "https://github.com/buildkite/buildkite-mcp-server/releases/download/v0.5.5/buildkite-mcp-server_Darwin_x86_64.tar.gz"
      sha256 "ac3694528e2edc588b2b68ff78a4a9ba9b3e49c83d2197f1fdd2c74686f37b54"
    end
    on_arm do
      url "https://github.com/buildkite/buildkite-mcp-server/releases/download/v0.5.5/buildkite-mcp-server_Darwin_arm64.tar.gz"
      sha256 "8f150332a17b28297488151a2f28051acd8cf0df5ce09991f848c404239ac784"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/buildkite/buildkite-mcp-server/releases/download/v0.5.5/buildkite-mcp-server_Linux_x86_64.tar.gz"
      sha256 "95299b5344571adae5f5fd53682e44a9240783cb20e19d772310d79bb22a5d1d"
    end
    on_arm do
      url "https://github.com/buildkite/buildkite-mcp-server/releases/download/v0.5.5/buildkite-mcp-server_Linux_arm64.tar.gz"
      sha256 "df225ce60d32ab54a20653818a9ba7cf36395906f436954ddd62defa2faf64f1"
    end
  end

  postflight do
    if system_command("/usr/bin/xattr", args: ["-h"]).exit_status == 0
      system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/buildkite-mcp-server"]
    end
  end

  # No zap stanza required
end
