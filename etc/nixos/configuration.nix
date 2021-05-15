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
  security.rtkit.enable = true;
  
  services.pipewire = {
  config.pipewire = {
    "context.properties" = {
      #"link.max-buffers" = 64;
      "link.max-buffers" = 16; # version < 3 clients can't handle more than this
      "log.level" = 2; # https://docs.pipewire.org/#Logging
      "default.clock.rate" = 48000;
      #"default.clock.quantum" = 1024;
      #"default.clock.min-quantum" = 32;
      #"default.clock.max-quantum" = 8192;
    };
    "context.modules" = [
      {
        name = "libpipewire-module-rtkit";
        args = {
          "nice.level" = -15;
          "rt.prio" = 88;
          "rt.time.soft" = 200000;
          "rt.time.hard" = 200000;
        };
        flags = [ "ifexists" "nofail" ];
      }
      { name = "libpipewire-module-protocol-native"; }
      { name = "libpipewire-module-profiler"; }
      { name = "libpipewire-module-metadata"; }
      { name = "libpipewire-module-spa-device-factory"; }
      { name = "libpipewire-module-spa-node-factory"; }
      { name = "libpipewire-module-client-node"; }
      { name = "libpipewire-module-client-device"; }
      {
        name = "libpipewire-module-portal";
        flags = [ "ifexists" "nofail" ];
      }
      {
        name = "libpipewire-module-access";
        args = {};
      }
      { name = "libpipewire-module-adapter"; }
      { name = "libpipewire-module-link-factory"; }
      { name = "libpipewire-module-session-manager"; }
      {
        name = "libpipewire-module-protocol-pulse";
        args = {
          "pulse.min.req" = "32/48000";
          "pulse.default.req" = "32/48000";
          "pulse.max.req" = "32/48000";
          "pulse.min.quantum" = "32/48000";
          "pulse.max.quantum" = "32/48000";
          "server.address" = [ "unix:native" ];
        };
      }
    ];
  };
  };

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
     wget home-manager firefox git spice-gtk
  ];

  environment.variables.EDITOR = "nvim";
  programs.neovim.enable = true;

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

   services.printing = {
        enable = true;
        drivers = [ pkgs.hplip ];
   };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.xserver.layout = "us";
   services.xserver.videoDrivers = [ "nvidia" ];
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the GNOME Desktop Environment.
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

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

  hardware.cpu.amd.updateMicrocode = true;
  nix.gc.automatic = true;

  # due to bug https://github.com/NixOS/nixpkgs/issues/32580 encountering on NVIDIA cards
  environment.variables.WEBKIT_DISABLE_COMPOSITING_MODE = "1";

  security.polkit.enable = true;
  security.wrappers.spice-client-glib-usb-acl-helper.source = "${pkgs.spice_gtk}/bin/spice-client-glib-usb-acl-helper";
}

