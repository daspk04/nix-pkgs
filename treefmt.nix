{ ... }:
{
  # Used to find the project root
  projectRootFile = "flake.lock";

  programs.yamlfmt.enable = true;

  programs.nixfmt.enable = true;
  programs.deadnix.enable = true;

  programs.shellcheck.enable = true;
  programs.shfmt.enable = true;
  settings.formatter.shfmt.includes = [ "*.envrc" ];
}
