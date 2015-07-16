require 'formula'

class BuildkiteAgent < Formula
  homepage 'https://buildkite.com/docs/agent'

  # No stable release of the new agents yet
  #
  # stable do
  #   version "2.0"
  #   url     "https://github.com/buildkite/agent/releases/download/v2.0/buildkite-agent-darwin-386-2.0.tar.gz"
  #   sha1    "9799813b94201c880397a1df3ddefd2ff6ca60e3"
  # end

  devel do
    version "1.0-beta.41"
    url     "https://github.com/buildkite/agent/releases/download/v1.0-beta.41/buildkite-agent-darwin-386-1.0-beta.41.745.tar.gz"
    sha1    "6cef9ead48a1fc3fa4b375b9f3fac4cb1ed1c5ab"
  end

  option 'token=', "Your account's agent token to add to the config on install"

  def default_agent_token
    "xxx"
  end

  def agent_token
    ARGV.value("token") || default_agent_token
  end

  def agent_hooks_path
    etc/"buildkite-agent/hooks"
  end

  def agent_builds_path
    var/"buildkite-agent/builds"
  end

  def agent_bootstrap_path
    etc/"bootstrap.sh"
  end

  def agent_config_path
    etc/"buildkite-agent/buildkite-agent.cfg"
  end

  def agent_config_dist_path
    share/"buildkite-agent.dist.cfg"
  end

  def install
    bin.mkpath
    agent_hooks_path.mkpath
    agent_builds_path.mkpath

    agent_hooks_path.install Dir["hooks/*"]
    etc.install "bootstrap.sh"

    agent_config_dist_path.write(default_config_file)

    if agent_config_path.exist?
      puts "\033[35mIgnoring existing config file at #{agent_config_path}\033[0m"
      puts "\033[35mFor changes see the updated dist copy at #{agent_config_dist_path}\033[0m"
    else
      agent_config_path.write(default_config_file(agent_token))
    end

    bin.install "buildkite-agent"
  end

  def default_config_file(agent_token = default_agent_token)
    File.read("buildkite-agent.cfg").
      gsub(/token=.+/,"token=\"#{agent_token}\"").
      gsub(/bootstrap-script=.+/, "bootstrap-script=\"#{agent_bootstrap_path}\"").
      gsub(/build-path=.+/, "build-path=\"#{agent_builds_path}\"").
      gsub(/hooks-path=.+/, "hooks-path=\"#{agent_hooks_path}\"")
  end

  def plist_manual
    "buildkite-agent start"
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
      </dict>
      </plist>
    EOS
  end

  def caveats
    <<-EOS.undent
      \033[32mbuildkite-agent is now installed!\033[0m#{agent_token_reminder}

      Configuration file (to configure agent meta-data, priority, name, etc):
          #{agent_config_path}

      Hooks directory (for customising the agent):
          #{agent_hooks_path}

      Builds directory:
          #{agent_builds_path}

      Log paths:
          #{var}/log/buildkite-agent.log
          #{var}/log/buildkite-agent.error.log

      If you set up the LaunchAgent, set your machine to auto-login as
      your current user. It's also recommended to install Caffeine
      (http://lightheadsw.com/caffeine/) to prevent your machine from going to
      sleep or logging out.
    EOS
  end

  def agent_token_reminder
    if agent_config_path.read.include?(default_agent_token)
      "\n      \n      \033[31mDon't forget to update your configuration file with your agent token\033[0m"
    end
  end

  test do
    system "#{bin}/buildkite-agent", "--help"
  end
end
