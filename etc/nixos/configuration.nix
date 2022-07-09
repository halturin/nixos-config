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
  boot.supportedFilesystems = [ "xfs" "ntfs" ];

  boot.cleanTmpDir = true;
  # latest LTS
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_5_12;


  networking = {
    hostName = "sevelen"; # Define your hostname.
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [ 22 80 443 ];
    };
    extraHosts = 
    ''
      140.238.210.133 devel-small-02
      152.67.70.58 devel-small-01
      152.67.92.84 devel
    '';
  };

  security.sudo.wheelNeedsPassword = false;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  #networking.extraHosts = {
  #  ''
  #    127.0.0.1 alterhost
  #  ''
  #};

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
     wget home-manager firefox git spice-gtk virt-manager
  ];

  environment.variables.EDITOR = "nvim";
  programs.neovim.enable = true;

  programs.steam.enable = true;

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

   # services.printing = {
   #      enable = true;
   #      drivers = [ pkgs.hplip ];
   # };
   # programs.system-config-printer.enable = true;

   services.gvfs.enable = true;
   services.onedrive.enable = true;


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  security.rtkit.enable = true;
  # Enable sound.
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };


  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.xserver.layout = "us";
   services.xserver.videoDrivers = [ "amdgpu" ];
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the GNOME Desktop Environment.
   services.xserver.displayManager.gdm.enable = true;
   services.xserver.desktopManager.gnome.enable = true;

   hardware.opengl.extraPackages = with pkgs; [
     rocm-opencl-icd
     rocm-opencl-runtime
   ];
   hardware.opengl.driSupport = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.taras = {
     isNormalUser = true;
     extraGroups = [ "audio" "wheel" "docker" "libvirtd" ]; # Enable ‘sudo’ for the user.

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

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  #virtualisation.vmware.host.enable = true;

  boot.kernelModules = [ "kvm-amd" "kvm-intel" "amdgpu" ];

  hardware.cpu.amd.updateMicrocode = true;
  nix.gc.automatic = true;

  # due to bug https://github.com/NixOS/nixpkgs/issues/32580 encountering on NVIDIA cards
  environment.variables.WEBKIT_DISABLE_COMPOSITING_MODE = "1";

  security.polkit.enable = true;
}

