# Codespace AI Template

Reusable GitHub Codespaces development template for AI-assisted coding.

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

OpenRouter credentials should be provided through GitHub Codespaces secrets, for example `OPENROUTER_API_KEY`. The secret is injected as an environment variable and must never be persisted to files under `/etc` or the container image.

## Intended use

This repository defines a portable `.devcontainer` configuration that can be reused across projects so each project can have its own correctly scoped Codespace while keeping the same AI development environment.

## Setup

1. Create a new Codespace from this repository
2. The `postCreateCommand` will provision the environment (install OpenCode, Git, CLI tools, run once)
3. The `postStartCommand` will verify the environment on each start (lightweight checks)
4. If you need to re-provision, run: `devcontainer rebuild`

## OpenCode Usage

After the Codespace is ready, OpenCode can be launched from the command line:

```bash
opencode
```

Or via the VS Code command palette (`Ctrl+Shift+P` → "OpenCode: Start OpenCode").

To provide an OpenCode token, set the `OPENCODE_TOKEN` Codespaces secret. If not set, OpenCode will attempt to install without a token (community mode).

## OpenRouter Configuration

Set the `OPENROUTER_API_KEY` Codespaces secret to use LLMs through OpenRouter. This secret is injected as an environment variable only and is never written to disk or committed to Git.

```bash
echo "export OPENROUTER_API_KEY=$OPENROUTER_API_KEY"
```

The key is available in your shell session without needing to store it in the repository.

## Rebuild / Reprovision

If you need to rebuild the devcontainer environment:

```bash
devcontainer rebuild
```

This re-runs the `postCreateCommand` and `postStartCommand` scripts.

## Troubleshooting

- If OpenCode fails to start, verify `OPENCODE_TOKEN` secret is set
- If GitHub CLI `gh auth status` returns "not authenticated", run `gh auth login`
- If Python/pip commands are not found, try restarting the terminal
- If Docker commands fail, ensure you're in a Codespace (Docker outside of Codespaces has limitations)
- If you need to reinstall base tools, run: `devcontainer up --force-pull`