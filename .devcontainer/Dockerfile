FROM mcr.microsoft.com/devcontainers/base:ubuntu

# [Option 1] Basic node setup
RUN su -c "apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    jq \
    ripgrep \
    unzip \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*" - root

# [Option 2] Install OpenCode
RUN su -c "curl -fsSL https://raw.githubusercontent.com/openocode/cli/main/scripts/install.sh | bash" - root 2>/dev/null || true

# [Option 3] Install Python and Node
RUN su -c "apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*" - root

# [Option 4] Install GitHub CLI
RUN su -c "curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg 2>/dev/null && echo \"deb [signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main\" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null && apt-get update && apt-get install -y gh" - root

USER vscode