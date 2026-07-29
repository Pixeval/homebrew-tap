# homebrew-tap

[Pixeval](https://github.com/Pixeval/Pixeval) 的自托管 [Homebrew](https://brew.sh) tap —— 一款跨平台 Pixiv 客户端，支持在 macOS、Linux、Windows 和 Android 上浏览、下载和管理插画作品。

[![brew test-bot](https://github.com/wu21-web/homebrew-tap/actions/workflows/tests.yml/badge.svg)](https://github.com/wu21-web/homebrew-tap/actions/workflows/tests.yml)


## 安装

```bash
# 添加此 tap
brew tap Pixeval/tap

# 安装 Pixeval
brew install --cask pixeval
```

## 卸载

```bash
brew uninstall --cask --zap pixeval

# 仅卸载应用，保留用户数据
brew uninstall --cask pixeval

# 移除 tap 本身
brew untap Pixeval/tap
```

## 更新

Pixeval 会在启动时自动检查更新。本 cask 跟踪最新发布版本，你也可以手动升级：

```bash
brew upgrade --cask pixeval
```

## 关于 Pixeval

Pixeval 是一款基于 Avalonia 和 .NET 构建的开源 Pixiv 客户端，原生跨平台运行。主要功能包括：

- 浏览、搜索和下载 Pixiv 插画作品
- 书签管理及稍后再看队列
- 订阅自动下载与自动播放
- 支持社区扩展

详细信息和源代码请参阅 [Pixeval 仓库](https://github.com/Pixeval/Pixeval)。

## 许可证

本 tap 使用 [MIT](LICENSE) 许可。Pixeval 使用 [GPL-3.0](https://github.com/Pixeval/Pixeval/blob/main/LICENSE) 许可。