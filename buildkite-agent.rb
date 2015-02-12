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
    version "1.0.beta.8"
    url     "https://github.com/buildkite/agent/releases/download/v1.0-beta.8/buildkite-agent-darwin-386.tar.gz"
    sha1    "66624f38c17e1d09f81232567fa43fe8a722275d"
  end

  option 'token=', "Your account's agent token"

  def agent_token
    ARGV.value("token") || ""
  end

  def agent_etc_path
    etc/"buildkite-agent"
  end

  def agent_builds_path
    var/"buildkite-agent/builds"
  end

  def install
    raise "You must specify your agent token using --token, for example:\n  brew install buildkite-agent --token=xxxx" if agent_token.empty?

    bin.mkpath
    agent_etc_path.mkpath
    agent_builds_path.mkpath

    bin.install "buildkite-agent"

    if (agent_etc_path/"bootstrap.sh").exist?
      cp "bootstrap.sh", agent_etc_path/"bootstrap.sh.default"
      $stderr.puts <<-EOS.undent

        An existing bootstrap.sh was found. To override with the latest version run:

          cp #{agent_etc_path/"bootstrap.sh.default"} #{agent_etc_path/"bootstrap.sh"}

      EOS
    else
      cp "bootstrap.sh", agent_etc_path/"bootstrap.sh"
    end
  end

  def plist
    # Hacky, but we can't use #agent_token in: plist_options(:manual => "string")
    self.class.instance_variable_set :@plist_manual, ["buildkite-agent start",
                                                      "--bootstrap-script #{agent_etc_path/"bootstrap.sh"}",
                                                      "--build-path #{agent_builds_path}",
                                                      "--token #{agent_token}",
                                                      "--meta-data mac=true"].join(" \\\n      ")

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

      If you want the agent to start on boot install the launch agent as below and set your
      machine to auto-login as your current user (#{ENV['USER']}). It's also recommended
      to install Caffeine (http://lightheadsw.com/caffeine/) to prevent your machine from
      going to sleep or logging out.
    EOS
  end

  test do
    system "#{bin}/buildkite-agent", "--help"
  end
end