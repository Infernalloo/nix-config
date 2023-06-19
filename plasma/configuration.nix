{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
    
  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Virtualbox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "inferno" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;

  # Enable networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";

  # Enable the Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  #  services.xserver.displayManager.autoLogin.enable = true;
  #  services.xserver.displayManager.autoLogin.user = "inferno";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.workstation = true;
  services.printing.drivers = with pkgs; [
   hplip
   hplipWithPlugin
   splix
   gutenprint
   gutenprintBin
   samsung-unified-linux-driver
  ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    }

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.inferno = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "sudo" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    util-linux
    fish
    git
    exa
    vim
    wget
    tldr
    starship
    neofetch
    pfetch
    nitch
    bunnyfetch
    bottom
    neovim
    vscode
    spotify
    discord
    steam
    lutris
    alacritty
    firefox
    brave
    vivaldi
    vivaldi-ffmpeg-codecs
    bottles
    partition-manager
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
  services.udev.packages = with pkgs; [
  ];
  
  # Excluding Plasma packages
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    oxygen
    khelpcenter
    plasma-browser-integration
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

