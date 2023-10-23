{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };

    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };

  # Networking
  networking = {
    hostName = "nixos";

    networkmanager = {
      enable = true;
    };

  };

  # Locales and time zone
  time.timeZone = "Europe/Rome";
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

  # Services
  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      desktopManager = {
        plasma5.enable = true;
	gnome.enable = false;
      };
      displayManager = {
        sddm.enable = true;
	defaultSession = "plasmawayland";
      };
    };
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    printing = {
      enable = true;
    };
    flatpak.enable = true;
  };

  # Virtualisation
  virtualisation = {
    waydroid.enable = true;
    libvirtd.enable = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.inferno = {
    isNormalUser = true;
    description = "inferno";
    extraGroups = [ "networkmanager" "wheel" "storage" "libvirtd"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  vim
  neovim
  curl
  wget
  git
  eza
  neofetch
  nitch
  bottom
  cmatrix
  asciiquarium
  vscode
  vivaldi
  vivaldi-ffmpeg-codecs
  firefox
  brave
  lightly-qt
  gcc
  python3
  gh
  ntfs3g
  onlyoffice-bin
  krita
  gimp
  steam
  virt-manager
  ];

  # Exlucde KDE packages
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
  elisa
  oxygen
  khelpcenter
  kwallet
  kwalletmanager
 ];

# Font
  fonts.packages= with pkgs; [
    (nerdfonts.override { fonts = ["JetBrainsMono" ]; })
];

  # Programs
  programs = {
    bash.shellAliases = {
      rs = "sudo nixos-rebuild switch";
      conf = "sudo nvim /etc/nixos/configuration.nix";
      ls = "eza -la --header --git --sort=ext --color=always --group-directories-first";
      la = "eza -a --header --git --sort=ext --color=always --group-directories-first";
      ll = "eza -l --header --git --sort=ext --color=always --group-directories-first";
      lt = "eza -aT --header --git --sort=ext --color=always --group-directories-first";
      bios = "systemctl reboot --firmware-setup";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      cmatrix = "cmatrix -C cyan";
    };
    hyprland = {
      enable = false;
      xwayland.enable = false;
    };
    dconf.enable = true;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
