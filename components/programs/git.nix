{...}: {
  programs.git = {
    enable = true;
    settings = {
      alias = {
        cl = "!f(){ git clone git@github.com:\${1} \${2}; };f";
        lg = "log --oneline --graph --decorate --all";
      };
      user = {
        email = "aidant@agylia.com";
        name = "Aidan Thomas";
      };
      init = {
        defaultBranch = "master";
      };
    };
    lfs.enable = true;
  };
}
