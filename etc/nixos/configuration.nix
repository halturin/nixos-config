# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.cleanTmpDir = true;

  networking = {
    hostName = "sevelen"; # Define your hostname.
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [ 22 80 443 ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  #networking.extraHosts = {
  #  ''
  #    127.0.0.1 alterhost
  #  ''
  #};

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.enp71s0.useDHCP = true;
  networking.interfaces.wlo2.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
   };

  # Set your time zone.
   time.timeZone = "Europe/Zurich";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     wget neovim home-manager firefox git 
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
     pinentryFlavor = "gnome3";
   };

  # List services that you want to enable:

    services = {
        syncthing = {
            enable = true;
            user = "taras";
            dataDir = "/archive/data";
            configDir = "/home/taras/.config/syncthing";
        };
    };

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
   sound.enable = true;
   hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.xserver.layout = "us";
   services.xserver.videoDrivers = [ "nvidia" ];
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
   services.xserver.displayManager.gdm.enable = true;
   services.xserver.desktopManager.gnome3.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.taras = {
     isNormalUser = true;
     extraGroups = [ "wheel" "docker" "libvirtd" ]; # Enable ‘sudo’ for the user.

     shell = pkgs.zsh;
   };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  fonts = {
    enableDefaultFonts = true;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [ "Iosevka" "FiraCode" "DroidSansMono" ];
    })
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (self: super: {
    	neovim = super.neovim.override {
    		viAlias = true;
    		vimAlias = true;
    	};
    })
  ];

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

  hardware.cpu.amd.updateMicrocode = true;
  nix.gc.automatic = true;

  # due to bug https://github.com/NixOS/nixpkgs/issues/32580 encountering on NVIDIA cards
  environment.variables.WEBKIT_DISABLE_COMPOSITING_MODE = "1";
}

