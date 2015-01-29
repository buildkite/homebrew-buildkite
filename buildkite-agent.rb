require 'formula'

class BuildkiteAgent < Formula
  homepage 'https://buildkite.com/docs/agent'
  url      'https://github.com/buildkite/agent/releases/download/v1.0-beta.7/buildkite-agent-darwin-386.tar.gz'
  version  '1.0.beta.7'
  sha1     '5d6851a3566d9c5d839ca77ffa70b65bf77a033c'

  option 'token=', "Your account's agent token"

  def agent_token
    ARGV.value("token") || `defaults read com.buildkite.agent token 2> /dev/null`.strip
  end

  def agent_etc_path
    etc/"buildkite-agent"
  end

  def agent_builds_path
    var/"buildkite-agent/builds"
  end

  def install
    raise "No agent token specified. Set the token in your user defaults first (defaults write com.buildkite.agent token xxxx) or pass it into homebrew using --token:\n  brew install buildkite-agent --token=xxxx" if agent_token.empty?

    bin.install "buildkite-agent"

    # This should be shipped with the release binary
    system "curl", "-O", "https://raw.githubusercontent.com/buildkite/agent/master/templates/bootstrap.sh"
    system "chmod", "u+x", "bootstrap.sh"


    if (agent_etc_path/"bootstrap.sh").exist?
      system "cp", "bootstrap.sh", agent_etc_path/"bootstrap.sh.default"
    else
      agent_etc_path.mkpath
      system "cp", "bootstrap.sh", agent_etc_path/"bootstrap.sh"
    end

    agent_builds_path.mkpath
  end

  def plist;
    # A little hacky, but we can't use #agent_token in the plist_options :manual string
    self.class.instance_variable_set(:@plist_manual, "BUILDKITE_BUILD_PATH=#{agent_builds_path} \\\n      buildkite-agent start \\\n        --token #{agent_token} \\\n        --bootstrap #{agent_etc_path/"bootstrap.sh"} \\\n        --meta-data mac=true")

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
        <string>#{agent_etc_path/"bootstrap.sh"}</string>
        <key>BUILDKITE_BUILD_PATH</key>
        <string>#{agent_builds_path}</string>
      </dict>
    </dict>
    </plist>
    EOS
  end

  def caveats
    <<-EOS.undent
      buildkite-agent is now installed!

      To tail the logs:
          tail -f #{var}/log/buildkite-agent.*

      If you want the agent to start on boot, install the launch agent as below and set your
      machine to auto-login as your current user (#{ENV['USER']}). We also recommend
      installing Caffeine (http://lightheadsw.com/caffeine/) to prevent your machine from
      going to sleep and logging out.
    EOS
  end

  test do
    system "#{bin}/buildkite-agent", "--help"
  end
end