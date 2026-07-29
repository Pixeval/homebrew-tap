# homebrew-tap

Self-hosted [Homebrew](https://brew.sh) tap for [Pixeval](https://github.com/Pixeval/Pixeval) — a cross-platform Pixiv client for browsing, downloading, and managing illustrations on macOS, Linux, Windows, and Android.

[![brew test-bot](https://github.com/Pixeval/homebrew-tap/actions/workflows/tests.yml/badge.svg)](https://github.com/Pixeval/homebrew-tap/actions/workflows/tests.yml)

## Install

```bash
# Add this tap
brew tap Pixeval/tap

# Install Pixeval
brew install --cask pixeval
```

## Uninstall

```bash
brew uninstall --cask --zap pixeval

# Or just remove the app, keeping your data
brew uninstall --cask pixeval

# Remove the tap itself
brew untap Pixeval/tap
```

## Update

Pixeval will update itself automatically on launch. The cask here tracks the latest release — you can upgrade it with:

```bash
brew upgrade --cask pixeval
```

## About Pixeval

Pixeval is an open-source Pixiv client built with Avalonia and .NET, running natively across platforms. Features include:

- Browsing, searching, and downloading Pixiv illustrations
- Bookmark management and watch-later queue
- Auto-download subscriptions and auto-slideshow
- Extensible via community extensions

See the [Pixeval repository](https://github.com/Pixeval/Pixeval) for full details and source code.

## License

This tap is [MIT](LICENSE). Pixeval is licensed under [GPL-3.0](https://github.com/Pixeval/Pixeval/blob/main/LICENSE).
