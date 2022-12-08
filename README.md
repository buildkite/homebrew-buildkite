# Buildkite Homebrew Formulae

A collection of [Buildkite](https://buildkite.com/) formulae for [Homebrew](http://brew.sh), a package manager for macOS.

## How do I install these formulae?

`brew install buildkite/buildkite/<formula>`

Or `brew tap buildkite/buildkite` and then `brew install <formula>`.

## Available Formulae

- [`buildkite-agent`](https://github.com/buildkite/agent) (Please see [installation notes](#buildkite-agent))
- [Buildkite CLI](https://github.com/buildkite/cli)
- [`terminal-to-html`](https://github.com/buildkite/terminal-to-html)

### Notes for `buildkite-agent`

To install [`buildkite-agent`](https://github.com/buildkite/agent):

```bash
brew install buildkite/buildkite/buildkite-agent
```

You then need to configure your agent token, which you can find your agent token on your "Agents" page in Buildkite:

```bash
sed -i '' "s/xxx/INSERT-YOUR-AGENT-TOKEN-HERE/g" "$(brew --prefix)"/usr/local/etc/buildkite-agent/buildkite-agent.cfg
```

If you want it start on login follow the `brew install` instructions to install the LaunchAgent plist. You’ll also want to make sure your PC is set to automatically login (the agent won’t launch until you've logged in) and you’ve prevented your machine from going to sleep.

Using a LaunchAgent instead of a LaunchDaemon does require a user login, but it allows your tests to use GUI tools (such as the iOS Simulator) and avoids any file permissions problems.

You can upgrade the agent using these commands:

```bash
brew update && brew upgrade buildkite-agent
```

## For further information about Homebrew

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
