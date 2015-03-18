require 'formula'

class BuildkiteAgent < Formula
  homepage 'https://buildkite.com/docs/agent'

  # No stable release of the new agents yet
  #
  # stable do
  #   version ""
  #   url     ""
  #   sha1    ""
  # end

  devel do
    version "1.0-beta.18"
    url     "https://github.com/buildkite/agent/releases/download/v1.0-beta.18/buildkite-agent-darwin-386.tar.gz"
    sha1    "275954e6f67bd91c06ad99d7683fdec673229672"
  end

  option 'token=', "Your account's agent token"
  option 'builds-path=', "Directory where builds are created (defaults to #{HOMEBREW_PREFIX}/var/buildkite-agent/builds)"
  option 'hooks-path=', "Directory where hooks are located (defaults to #{HOMEBREW_PREFIX}/share/buildkite-agent/hooks)"

  def agent_token
    ARGV.value("token") || ""
  end

  def agent_hooks_path
    Pathname(ARGV.value("hooks-path") || etc/"buildkite-agent/hooks")
  end

  def agent_share_path
    share/"buildkite-agent"
  end

  def agent_builds_path
    Pathname(ARGV.value("builds-path") || var/"buildkite-agent/builds")
  end

  def agent_bootstrap_path
    agent_share_path/"bootstrap.sh"
  end

  def install
    raise "You must specify your agent token using --token, for example:\n  brew install buildkite-agent --token=xxxx" if agent_token.empty?

    bin.mkpath
    agent_hooks_path.mkpath
    agent_builds_path.mkpath
    agent_share_path.mkpath

    agent_hooks_path.install Dir["hooks/*"]
    agent_share_path.install "bootstrap.sh"

    bin.install "buildkite-agent"
  end

  def plist_manual
    ["buildkite-agent start",
     "--bootstrap-script #{HOMEBREW_PREFIX}/share/buildkite-agent/bootstrap.sh",
     "--build-path #{agent_builds_path}",
     "--hooks-path #{agent_hooks_path}",
     "--token #{agent_token}",
     "--meta-data mac=true"].join(" \\\n      ")
  end

  def plist
    <<-EOS.undent
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>WorkingDirectory</key>
        <string>#{HOMEBREW_PREFIX}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/buildkite-agent</string>
          <string>start</string>
          <!--<string>--debug</string>-->
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>ProcessType</key>
        <string>Interactive</string>
        <key>ThrottleInterval</key>
        <integer>30</integer>
        <key>StandardOutPath</key>
        <string>#{var}/log/buildkite-agent.log</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/buildkite-agent.error.log</string>
        <key>EnvironmentVariables</key>
        <dict>
          <key>BUILDKITE_AGENT_TOKEN</key>
          <string>#{agent_token}</string>
          <key>BUILDKITE_AGENT_META_DATA</key>
          <string>mac=true</string>
          <key>BUILDKITE_BOOTSTRAP_SCRIPT_PATH</key>
          <string>#{agent_bootstrap_path}</string>
          <key>BUILDKITE_BUILD_PATH</key>
          <string>#{agent_builds_path}</string>
          <key>BUILDKITE_HOOKS_PATH</key>
          <string>#{agent_hooks_path}</string>
        </dict>
      </dict>
      </plist>
    EOS
  end

  def caveats
    <<-EOS.undent
      buildkite-agent is now installed!

      Log paths:
          #{var}/log/buildkite-agent.log
          #{var}/log/buildkite-agent.error.log

      Build directory:
          #{agent_builds_path}

      Hooks directory:
          #{agent_hooks_path}

      If you set up the LaunchAgent below, set your machine to auto-login as
      your current user. It's also recommended to install Caffeine
      (http://lightheadsw.com/caffeine/) to prevent your machine from going to
      sleep or logging out.
    EOS
  end

  test do
    system "#{bin}/buildkite-agent", "--help"
  end
end
