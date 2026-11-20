# Changelog

All notable changes to this project are documented in this file. The format
follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and versions
follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Files no longer open with every block folded. The ftplugin sets `foldlevel`
  to 99, unless `foldlevelstart` is set.

## [1.0.0] - 2026-11-20

First public release.

### Added

- `ios` filetype for `*.ios`, `*-confg`, `running-config` and `startup-config`.
  Files ending in `.cfg`, `.conf` or `.txt` are detected by their first 50
  lines, and other files with these extensions keep their usual filetype.
- Syntax highlighting for comments, section commands, `no`, `permit`, `deny`,
  `shutdown`, interface names, IPv4 and IPv6 addresses, masks, Media Access
  Control (MAC) addresses, secrets and banners. The text after `description`
  and `remark` is shown as a string.
- ftplugin with `! %s` comments, a one-space indent, indent folding and `-` in
  `iskeyword`.
- Omni-completion that offers global commands at column 0 and section commands
  inside `interface`, `router`, `line`, `ip access-list`, `ipv6 access-list`,
  `ip dhcp pool`, `route-map`, `vrf`, `class-map`, `policy-map` and `vlan`.
- 13 snippets in VSCode format, registered with LuaSnip through
  `require("ios").setup()`.
- Help file under `:help ios.nvim`.

[Unreleased]: https://github.com/a-mango/ios.nvim/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/a-mango/ios.nvim/releases/tag/v1.0.0
