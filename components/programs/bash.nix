{...}: {
  programs.bash = {
    enable = true;
    shellAliases = {
      develop = "nix develop ~/.dotfiles#development";

      ll = "ls -la";
      ".." = "cd ..";
      c = "clear";
      cf = "clear && fastfetch";
      sd = "cd && cd $(fd -t directory --hidden --exclude go/ | fzf)";
    };
    enableCompletion = true;
    initExtra = ''
      EDITOR=nvim
      clear && fastfetch
    '';
  };
}
