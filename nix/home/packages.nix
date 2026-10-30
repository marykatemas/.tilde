# Command-line tools installed for the user on every host.
#
# This is the shared daily toolkit: shell and prompt, editors, git and
# forge tooling, and the Rust rewrites of the classic Unix utilities.
# Commented entries are packages kept intentionally off (provided some
# other way, or simply not wanted yet) rather than forgotten.
{pkgs, ...}: {
  home.packages = with pkgs; [
    age
    aria2
    atuin
    bash
    bat
    btop
    carapace
    coreutils
    curl
    direnv
    docker
    docker-compose
    doggo
    duf
    dust
    eza
    fastfetch
    fd
    ffmpeg
    fzf
    gh
    ghostscript
    git
    git-crypt
    gitleaks
    delta
    glab
    kubernetes-helm
    htop
    imagemagick
    jq
    just
    k9s
    kubectx
    kubectl
    lazydocker
    lazygit
    lua5_1
    lua51Packages.luarocks
    mise
    mtr
    ncdu
    # neovim
    nushell
    ollama
    ripgrep
    p7zip
    pnpm
    poppler
    procs
    # rsync
    sesh
    shellcheck
    shfmt
    smartmontools
    starship
    # stow
    tectonic
    television
    tlrc
    tmux
    uv
    vim
    watch
    wget
    xh
    yazi
    yq
    zoxide
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    nixfmt
    unzip
    restic
    nufmt
    cliamp
    chafa
    tmuxp
    clock-rs
    # opencode
    ghgrab
    herdr
    # yt-dlp
    direnv
  ];
}
