## 0.0.16 (2026-04-24)

    Refactor

        Reorganized YAML schema configuration for the development environment.
        Use Schemastore JSON schemas for both Helm and Yaml LSPs (#15)

## 0.0.15 (2026-04-24)

    chore
        switch to devenv v2

## 0.0.14 (2026-04-11)

## 0.0.13 (2026-03-31)

    New Features
        add Dockerls LSP to IDE setup

    Improvements
        add JSON schemas for Kyberno ValidatingPolicy CRD and
        HTTPS-Wrench request configuration

## 0.0.12 (2026-03-21)

    Documentation
        Added comprehensive Kyverno CRD schemas reference documentation with usage examples

    New Features
        Added gitlineage plugin for Neovim commit navigation and history viewing
        Enabled Diffview plugin for enhanced diff visualization
        Expanded YAML schema validation with additional schema sources for improved editor support

## 0.0.11 (2026-02-24)

    New Features
        Added vim-marks plugin for bookmark and mark management in Neovim.
        Added configurable YAML schema support with schemastore integration and custom schema definitions for improved IDE functionality.
        Added LSP buffer formatting keybinding.

    Improvements
        Enhanced command-line argument forwarding in IDE scripts.

## 0.0.10 (2026-01-21)

    New Features:
        Enhanced diagnostics and lint integration across Go, Terraform, Python, Shell
        and YAML. Per-filetype diagnostic toggling for shell and other filetypes
        (automatic enable/disable). Added inline diagnostic display with a new keyboard
        shortcut to toggle visibility. UI improvements: cursorline highlighting
        enhancements.

    Bug Fixes:
        Disabled high-CPU Bash language features to improve performance.

## 0.0.9 (2026-01-15)

    New Features
        Added keyboard shortcut to toggle inline code hints/biscuits.
        Added keyboard shortcut to toggle Markdown preview split.

    Configuration
        Markdown preview now disabled by default.
        Markdown extension settings updated to use a structured configuration (preview explicitly turned off).

## 0.0.8 (2026-01-10)

    Update Go formatter configuration and Neovim theme (#8)

    * chore: set WinSeparator

    define visible border for split windows according to theme colors

    * refactor: format support for go language

    disable Nvf's go language support since it allowed only one formatter,
    set Conform to use gofumpt and goimports as formatters for go FT,
    remove global autoformat disable check.

## 0.0.7 (2026-01-08)

### Refactor

- formatter support for minimal config (\#6)

## 0.0.5 (2026-01-04)

### Fix

- remove yamlfmt as formatter from IDE settings (\#5)

## 0.0.4 (2026-01-03)

### Feat

- enable Terraform LSP (\#3)

### Fix

- wrong inherit

## 0.0.3 (2026-01-01)

### Feat

- enable blink autocomplete for IDE setup (\#2)

### Refactor

- autocomplete for minimal setup, switch to mini surround feat: enable rainbow
  brackets

## 0.0.2 (2025-12-30)

### Feat

- improve treesitter and helm-ls settings (\#1)

## 0.0.1 (2025-12-27)
