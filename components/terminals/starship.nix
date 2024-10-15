{...}: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      format = builtins.concatStringsSep "" [
        "[  ](bg:#cdd6f4 fg:#11111b)"
        "$nix_shell"
        "[](bg:#89b4fa fg:#cdd6f4)"
        "$directory"
        "[](fg:#89b4fa bg:#1e1e2e)"
        "$git_branch"
        "$git_status"
        "[](fg:#1e1e2e bg:#181825)"
        "$time"
        "[ ](fg:#181825)"
        "$line_break"
        "$character"
      ];
      add_newline = false;
      character = {
        success_symbol = "[ 󰜴](bold green)";
        error_symbol = "[ 󰜴](bold red)";
      };
      directory = {
        style = "bold fg:#11111b bg:#89b4fa";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      git_branch = {
        symbol = "";
        style = "bg:#1e1e2e";
        format = "[[ $symbol $branch ](fg:#89b4fa bg:#1e1e2e)]($style)";
      };
      git_status = {
        style = "bg:#1e1e2e";
        format = "[[($all_status$ahead_behind )](fg:#89b4fa bg:#1e1e2e)]($style)";
      };
      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute format
        style = "bg:#181825";
        format = "[[  $time ](fg:#cdd6f4 bg:#181825)]($style)";
      };
      nix_shell = {
        disabled = false;
        style = "bold bg:#cdd6f4 fg:#11111b";
        format = "[ (\($name\)) ]($style)";
      };
    };
  };
}
