{pkgs, ...}: {
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = with pkgs; [
    commitizen
    git
  ];

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  # https://devenv.sh/basics/
  enterShell = ''
    hello         # Run scripts directly
    git --version # Use packages
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  # Keep security hooks on by default; allow opt-out via env.
  git-hooks = let
    disableHooks = builtins.getEnv "DISABLE_GIT_HOOKS" == "1";
  in {
    hooks = {
      detect-private-keys.enable = !disableHooks;
      trufflehog.enable = !disableHooks;
      # Keep only known-broken hooks disabled explicitly.
      comrak.enable = false;
    };
  };
}
