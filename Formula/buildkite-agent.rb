class BuildkiteAgent < Formula
  desc "Build runner for use with Buildkite"
  homepage "https://buildkite.com/docs/agent"

  stable do
    version "3.118.0"
    if Hardware::CPU.arm?
      url     "https://github.com/buildkite/agent/releases/download/v3.118.0/buildkite-agent-darwin-arm64-3.118.0.tar.gz"
      sha256  "3550a44f6f41fb11396fe03982dd025ee4ca78cf7517eb3f27a5bf6e4fce015b"
    else
      url     "https://github.com/buildkite/agent/releases/download/v3.118.0/buildkite-agent-darwin-amd64-3.118.0.tar.gz"
      sha256  "07670989dcaa53c223b98116b87d560b7a516c3c64288ccc284422167e8267e9"
    end
  end

  def agent_etc
    etc/"buildkite-agent"
  end

  def agent_var
    var/"buildkite-agent"
  end

  def agent_hooks_path
    agent_etc/"hooks"
  end

  def agent_builds_path
    agent_var/"builds"
  end

  def agent_plugins_path
    agent_var/"plugins"
  end

  def agent_bootstrap_path
    if stable?
      agent_etc/"bootstrap.sh"
    else
      opt_bin/"buildkite-agent bootstrap"
    end
  end

  def agent_config_path
    agent_etc/"buildkite-agent.cfg"
  end

  def agent_config_dist_path
    pkgshare/"buildkite-agent.dist.cfg"
  end

  def install
    agent_etc.mkpath
    agent_var.mkpath
    pkgshare.mkpath
    agent_hooks_path.mkpath
    agent_builds_path.mkpath

    agent_hooks_path.install Dir["hooks/*"]
    if stable?
      agent_etc.install "bootstrap.sh"
    end

    agent_config_dist_path.write(default_config_file)

    if agent_config_path.exist?
      puts "\033[35mIgnoring existing config file at #{agent_config_path}\033[0m"
      puts "\033[35mFor changes see the updated dist copy at #{agent_config_dist_path}\033[0m"
    else
      agent_config_path.write(default_config_file)
    end

    bin.install "buildkite-agent"
  end

  def default_config_file
    File.read("buildkite-agent.cfg")
        .gsub(/bootstrap-script=.+/, "bootstrap-script=\"#{agent_bootstrap_path}\"")
        .gsub(/build-path=.+/, "build-path=\"#{agent_builds_path}\"")
        .gsub(/hooks-path=.+/, "hooks-path=\"#{agent_hooks_path}\"")
        .gsub(/plugins-path=.+/, "plugins-path=\"#{agent_plugins_path}\"")
  end

  def caveats
    <<~EOS
      \033[32mbuildkite-agent is now installed!\033[0m

      \033[31mDon't forget to update your configuration file with your agent token\033[0m

      Configuration file (to configure agent token, meta-data, priority, name, etc):
          #{agent_config_path}

      Hooks directory (for customising the agent):
          #{agent_hooks_path}

      Builds directory:
          #{agent_builds_path}

      Log paths:
          #{var}/log/buildkite-agent.log
          #{var}/log/buildkite-agent.error.log

      If you set up the LaunchAgent, set your machine to auto-login as
      your current user.

      To prevent your machine from sleeping or logging out, use `caffeinate`. For
      example, running `caffeinate -i buildkite-agent start` runs buildkite-agent
      and prevents the system from idling until it exits. Run `man caffeinate` for
      details.

      To run multiple agents simply run the buildkite-agent start command
      multiple times, or duplicate the LaunchAgent plist to create another
      that starts on login.
    EOS
  end

  service do
    run [
      HOMEBREW_PREFIX/"bin/buildkite-agent", "start", 
        "--config", etc/"buildkite-agent/buildkite-agent.cfg"
    ]
    working_dir HOMEBREW_PREFIX/"bin"   # Why?
    keep_alive successful_exit: false
    environment_variables PATH: HOMEBREW_PREFIX/"bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    process_type :interactive
    log_path var/"log/buildkite-agent.log"
    error_log_path var/"log/buildkite-agent.log"
  end

  test do
    system "#{bin}/buildkite-agent", "--help"
  end
end
