{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
    boot.loader.systemd-boot.enable = false;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.efiSupport = true;

  # Enabl networking
    networking.hostName = "nixos"; # Define your hostname.
    networking.networkmanager.enable = true;

  # Set your time zone.
    time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "it_IT.UTF-8";
      LC_IDENTIFICATION = "it_IT.UTF-8";
      LC_MEASUREMENT = "it_IT.UTF-8";
      LC_MONETARY = "it_IT.UTF-8";
      LC_NAME = "it_IT.UTF-8";
      LC_NUMERIC = "it_IT.UTF-8";
      LC_PAPER = "it_IT.UTF-8";
      LC_TELEPHONE = "it_IT.UTF-8";
      LC_TIME = "it_IT.UTF-8";
    };

  # Enable the X11 windowing system.
    services.xserver.enable = true;

  # Enable hyprland
    programs.hyprland.enable = true;

  # Enable the KDE Plasma Desktop Environment.
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;
    services.xserver.displayManager.defaultSession = "plasmawayland";

  # Enable the GNOME Desktop Environment.
    # services.xserver.displayManager.gdm.enable = true;
    # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
    services.xserver = {
      layout = "us";
      xkbVariant = "";
    };

  # Enable CUPS to print documents.
    services.printing.enable = true;

  # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.inferno = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
    };

  # Packages support
    nixpkgs.config.allowUnfree = true;
    services.flatpak.enable = true;

  # Enable virtualbox
  #  virtualisation.virtualbox.host.enable = true;
  #  virtualisation.virtualbox.guest.enable = true;
  #  virtualisation.virtualbox.guest.x11 = true;
  #  virtualisation.virtualbox.host.enableExtensionPack = true;
  #  users.extraGroups.vboxusers.members = [ "inferno" ];

  # Packages to install system wide
    environment.systemPackages = with pkgs; [
      util-linux
      vim
      neovim
      git
      exa
      neofetch
      nitch
      bottom
      vscode
      kitty
      firefox
      bitwarden
      mako
      hyprpaper
      networkmanagerapplet
    ];

  # Exclude some Plasma pkgs
  #  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
  #      elisa
  #      oxygen
  #      khelpcenter
  #      kwallet
  #      kwalletmanager
  #      plasma-browser-integration
  #  ];

  # Font
    fonts.fonts = with pkgs; [
      (nerdfonts.override { fonts = ["JetBrainsMono" ]; })
    ];

    # services.openssh.enable = true;
    system.stateVersion = "23.05";

}
