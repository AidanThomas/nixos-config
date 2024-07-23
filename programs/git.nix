{...}: {
  programs.git = {
    enable = true;
    userEmail = "aidant@agylia.com";
    userName = "Aidan Thomas";
    aliases = {
      cl = "!f(){ git clone git@github.com:\${1} \${2}; };f";
      lg = "log --oneline --graph --decorate --all";
    };
    lfs.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "master";
      };
    };
  };
}
