# Codespace AI Template

Reusable GitHub Codespaces development template for AI-assisted coding.

The goal is to make a new Codespace ready for development with the minimum possible manual setup, including OpenCode, GitHub CLI, common development tooling, and support for OpenRouter configuration through Codespaces secrets.

## Goals

A new Codespace created from this repository should automatically provide:

- OpenCode
- Git and GitHub CLI
- Node.js and npm
- Python 3 and pip
- Docker tooling where practical
- curl, wget, jq, ripgrep, unzip and build tools
- a consistent shell/development environment
- OpenRouter support without storing API keys in Git

## Secrets

Never commit API keys, tokens, passwords, private keys or other credentials to this repository.

OpenRouter credentials should be provided through GitHub Codespaces secrets, for example `OPENROUTER_API_KEY`.

## Intended use

This repository will define a portable `.devcontainer` configuration that can be reused across projects so each project can have its own correctly scoped Codespace while keeping the same AI development environment.

## Status

Initial setup is in progress. See Issue #1 for the first implementation specification.
