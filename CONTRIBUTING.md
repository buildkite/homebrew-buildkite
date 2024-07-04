# Contributing

Install from this tap:

```
brew install buildkite/buildkite/bk
```

This will also clone the tap into your homebrew directory, e.g.:

```
/opt/homebrew/Library/Taps/buildkite/buildkite
```

In that directory is a full git checkout.

To make a change, go there and create a new branch. Add your formula (copy one of the others), or start editing a formula.

Make sure it installs. While you have your branch checked out you can reinstall the formula using the same install instructions -- it will use your already checked out branch:

```
brew reinstall buildkite/buildkite/bk
```

If there are tests (there should be!) you should run them as well:

```
brew test buildkite/buildkite/bk
```

Commit it onto the branch, push, and open a pull request etc as per normal.

Check out the Homebrew documentation for more:

https://docs.brew.sh
