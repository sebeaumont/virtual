# more or less minimal
#
{ config, pkgs, ... }:

let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # provide an unstable channel
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "labnix"; 
  networking.useDHCP = false;
  networking.interfaces.enp63s0.useDHCP = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "Europe/London";

  environment.systemPackages = with pkgs; [
     wget curl emacs-nox git zsh w3m tmux
     unstable.ghc
     unstable.cabal-install
     unstable.stack
   ];

  services.openssh.enable = true;
  services.nixosManual.showManual = true;
  
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  programs.zsh.enable = true;
  
  users.users.seb = {
     isNormalUser = true;
     shell = pkgs.zsh;
     extraGroups = [ "wheel" ]; 
   };

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "intel" ];

  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager.xmonad.haskellPackages = pkgs.unstable.haskell.packages.ghc883;       
  services.xserver.autorun = true;

  system.stateVersion = "20.03"; # Did you read the comment?

}

