{ pkgs, ... }: {
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  time.timeZone = "UTC";

  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    wget
  ];
}
