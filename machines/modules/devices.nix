{pkgs, ...}: {
  services.ratbagd.enable = true;
  hardware.keyboard.zsa.enable = true;
  environment.systemPackages = with pkgs; [
    piper # needed to flash mouse profiles.
    wally-cli # needed to flash kbd profiles.
  ];
}
