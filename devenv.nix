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
  git-hooks = {
    hooks = {
      alejandra.enable = true;
      commitizen.enable = true;
      comrak.enable = true;
      deadnix.enable = true;
      detect-private-keys.enable = true;
      flake-checker.enable = true;
      gitlint.enable = true;
      selene.enable = true;
      shellcheck.enable = true;
      trufflehog.enable = true;
    };
  };
}
