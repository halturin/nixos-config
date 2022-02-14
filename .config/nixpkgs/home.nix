{ config, pkgs, lib, ... }:
let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.bat.enable = true;
  programs.broot.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";

  home.file.".config/vifm/colors".source = ./vifm/colors;
  home.file.".config/vifm/vifm.icons".source = ./vifm/vifm.icons;
  home.file.".config/vifm/vifmrc".source = ./vifm/vifmrc;
  home.file.".local/share/backgrounds/wp1.png".source = ./wp1.png;

  home.file.".tigrc".source = ./dotfiles/.tigrc;
  home.file.".multitail.conf".source = ./dotfiles/.multitail.conf;

  xdg.enable = true;

  home.packages = with pkgs; [
    mc htop neofetch vifm-full iftop nethogs

    # some non-free software
    spotify skype postman teams slack

    cava cmus catimg

    kubernetes minikube docker-machine-kvm2

    tmux ctags cmake gnumake gcc git tig gitg binutils xclip file killall multitail
    dhex jq unzip graphviz firejail

    libxfs ntfs3g


    ffmpeg mpv wmctrl pavucontrol screenkey obs-studio zathura peek
    mdadm

    go goimports gopls golint erlang python3 gdb

    exa
    ripgrep
    poke # editor for binary data http://www.jemarch.net/poke
    upx # upx --best --lzma ./binary

    # syncthing-gtk
    chromium vivaldi

    inetutils dig v4l-utils

    vscode meld

    iosevka dejavu_fonts ttf_bitstream_vera noto-fonts

    gnome.gnome-tweaks gnome.gnome-boxes gnome.gnome-sound-recorder
    #gnomeExtensions.paperwm

    transmission-gtk gimp inkscape
    rxvt-unicode
    tdesktop

    dumptorrent # for vifm

    iotop powertop

    lm_sensors

    #materia-theme

    cryptsetup # for LUKS image
    wally-cli # for my ergodox keyboard

    #shortwave # internet radio

  ];

  programs.fzf.enable = true;


  programs.git = {
    enable = true;
    userEmail = "halturin@gmail.com";
    userName = "Taras Halturin";
    signing.key = "4949A906AB2FE101";
    signing.signByDefault = true;

    aliases = {
      s = "status";
      b = "branch";

      ba = "branch -a -v -v";
      bd = "branch -D";

      ci = "commit";
      co = "checkout";
      cob = "checkout -b";

      l = "log -C --decorate";
      ls = "log -C --stat --decorate";
      lsd = "log --graph '--pretty=tformat:%Cblue%h%Creset %Cgreen%ar%Creset %Cblue%d%Creset %s' --all --simplify-by-decoration";

      extraConfig =
        ''

        '';
    };

  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    shellAliases = import ./dotfiles/aliases.nix;
    defaultKeymap = "viins";

    sessionVariables = rec {
      # NVIM_TUI_ENABLE_TRUE_COLOR="1";
      # ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=3";
      ZSH_THEME = "minimal";
      KEY_TIMEOUT = 20;

      EDITOR = "nvim";
      VISUAL = EDITOR;
      GIT_EDITOR = EDITOR;

      NIX_PATH = "$HOME/.nix-defexpr/channels:nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels";

      # Golang
      GOPATH = "$HOME/devel/go";

      # Rust
      CARGOPATH = "$HOME/.cargo";

      PATH = "$GOROOT/bin:$GOPATH/bin:$CARGOPATH/bin:$PATH";

    };

    initExtraBeforeCompInit = ''
      fpath=($HOME/.zsh/plugins/git/functions $HOME/.zsh/plugins/utility/functions $HOME/.zsh/plugins/git-info/functions $fpath)


      autoload -Uz git-alias-lookup git-branch-current git-branch-delete-interactive git-dir git-ignore-add git-root git-stash-clear-interactive git-stash-recover git-submodule-move git-submodule-remove mkcd mkpw coalesce git-action git-info

      ergo() { cd $GOPATH/src/github.com/ergo-services/ergo/$1 }
      compctl -/ -W $GOPATH/src/github.com/ergo-services/ergo/ ergo

      devel() { cd $HOME/devel/$1 }
      compctl -/ -W $HOME/devel/ devel

    '';

    # limits can be defined via security.pam.loginLimits in the system configuration
    # details are here https://search.nixos.org/options?channel=unstable&query=security.pam.
    initExtra = ''
      bindkey 'jj' vi-cmd-mode

      neofetch

      ulimit -n 500000

      alias ...="cd -"

    '';

   plugins = [
      {
        name = "s1ck94";
        file = "s1ck94.zsh-theme";
        src = pkgs.fetchFromGitHub {
          owner = "zimfw";
          repo = "s1ck94";
          rev = "0ea247f6ff1a7a7fcb639905cd55d315872840d2";
          sha256 = "1hmfdcb298wf35qamngnsjw29glpzdmsfhmlklcq0fqilmmamc6n";
        };
      }

      {
        name = "completion";
        file = "init.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zimfw";
          repo = "completion";
          rev = "db9c17717864e424e3e0e2f69afa4b83db78b559";
          sha256 = "1r8mqxrm05jzj6xxmjipgxlndkd1qdphbw3i71mf0k43ywh1i5z0";
        };
      }
      {
        name = "environment";
        file = "init.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zimfw";
          repo = "environment";
          rev = "016d897e909eca6efc6f8bb95b4b952e0b4a5424";
          sha256 = "0qad6b1izmzls0m0r69czvylnid2m31j7ww56lncw1hv6g1j6q3j";
        };
      }

      {
        name = "git";
        file = "init.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zimfw";
          repo = "git";
          rev = "91c4d36552dc16acea8bd5e1c91f7b9085ac03e1";
          sha256 = "1qr2ya2n73c0mvnxr3mc9m4y7grq0izi97sy97hds8dvv855ya08";
        };
      }

      {
        name = "git-info";
        src = pkgs.fetchFromGitHub {
          owner = "zimfw";
          repo = "git-info";
          rev = "1ca640c73aa5cb9a57f31c65ac46c1fb50919adc";
          sha256 = "1kw42vmc6xgh8zk3fr6f1ddi21f7lvpqrq8myivr0p4bw7gnfgg4";
        };
      }

      {
        name = "input";
        file = "init.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zimfw";
          repo = "input";
          rev = "a9f84332fa1023cc6c25295df71cb2b743516d66";
          sha256 = "0dpl0spvjwg8cvgysy74grchjfvfw95lbgs9627sbvbihvzibbmr";
        };
      }
      {
        name = "termtitle";
        file = "init.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zimfw";
          repo = "termtitle";
          rev = "eb629ab80431bef60bdce29c82eb3ff20369b3e9";
          sha256 = "043wsmhdixhk4pc3l15sfqrql7b6q862px7fx31vg1zrkkl5wqva";
        };
      }
      {
        name = "utility";
        file = "init.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zimfw";
          repo = "utility";
          rev = "e88c45bda6cfc6169832a0606b8991cf734f5608";
          sha256 = "17w0pdq72a1743b5pgrqxicj628czgqgnbclb9fh2c9xcksnxbg5";
        };
      }

      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.zsh-history-substring-search;
      }
    ];

  };


  programs.neovim = {
	enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./dotfiles/.vimrc;
	plugins = with pkgs.vimPlugins; [
		vim-nix
		vim-go
		gruvbox
        nord-vim
        vim-airline
        vim-airline-themes
        nerdtree
        fzf-vim
        vim-fugitive
        tagbar
        vim-startify

        (pkgs.vimUtils.buildVimPlugin {
          pname = "vim-numbertoggle";
          version = "1.1.1";
          src = pkgs.fetchFromGitHub {
            owner = "jeffkreeftmeijer";
            repo = "vim-numbertoggle";
            rev = "cfaecb9e22b45373bb4940010ce63a89073f6d8b";
            sha256 = "1rrmvv7ali50rpbih1s0fj00a3hjspwinx2y6nhwac7bjsnqqdwi";
          };
        })
        (pkgs.vimUtils.buildVimPlugin {
          pname = "erlang-compiler";
          version = "1.1.1";
          src = pkgs.fetchFromGitHub {
            owner = "vim-erlang";
            repo = "vim-erlang-compiler";
            rev = "dec059a4f391b56ee13b977deecb0d646c10b631";
            sha256 = "0gb6wkq8skwhgcrc5dk3jinyh71x4db1j44bgw50slsilmg99d09";
          };
        })
        (pkgs.vimUtils.buildVimPlugin {
          pname = "erlang-omnicomplete";
          version = "1.1.1";
          src = pkgs.fetchFromGitHub {
            owner = "vim-erlang";
            repo = "vim-erlang-omnicomplete";
            rev = "2f980dd8f1861e00ea14dcd5ecc370e71af695fb";
            sha256 = "1i3c7ybahmb4az2njzvfnvx39bqiyqhf43n32rhpc3xg05y3bk7d";
          };
        })
        (pkgs.vimUtils.buildVimPlugin {
          pname = "erlang-runtime";
          version = "1.1.1";
          src = pkgs.fetchFromGitHub {
            owner = "vim-erlang";
            repo = "vim-erlang-runtime";
            rev = "b8e4ea6381d3cfab8af6c8e9373699ffc42921b1";
            sha256 = "1zmkv85k1h0ax1m878ylcsvbw4kl27lg02sjgy8913mp0hvzyh2q";
          };
        })
        (pkgs.vimUtils.buildVimPlugin {
          pname = "erlang-tags";
          version = "1.1.1";
          src = pkgs.fetchFromGitHub {
            owner = "vim-erlang";
            repo = "vim-erlang-tags";
            rev = "e4bfe17793956f28846b7969f4620dbb168bd044";
            sha256 = "0r0dk8dblw3r7c30p6pbcyavs688m0776npqgpxa9gafg7ihjczb";
          };
        })
	];
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    #shortcut = "a"; we cant use it due to vim' feature of inc/dec numbers via ctrl-a/ctrl-x
    terminal = "tmux-256color";

    extraConfig = ''
      set -g focus-events on
      set -g mouse on

      # set terminal window title to be a name of tmux window
      set-option -g set-titles on
      set-option -g set-titles-string "#S / #W"

      bind -n M-'"' split-window -v -c '#{pane_current_path}'
      bind -n M-"'" split-window -h -c '#{pane_current_path}'
      unbind "%"
      unbind '"'


      bind s copy-mode
      bind P paste-buffer

      # Use v to trigger selection
      bind-key -T copy-mode-vi v send-keys -X begin-selection

      # Use y to yank current selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      bind -n M-J resize-pane -D
      bind -n M-K resize-pane -U
      bind -n M-H resize-pane -L
      bind -n M-L resize-pane -R
      bind -n M-Z resize-pane -Z

      bind -n M-q display-panes

      bind -n M-w choose-tree -Zw

      bind -n M-1 select-window -t :=1
      bind -n M-2 select-window -t :=2
      bind -n M-3 select-window -t :=3
      bind -n M-4 select-window -t :=4
      bind -n M-5 select-window -t :=5
      bind -n M-6 select-window -t :=6
      bind -n M-7 select-window -t :=7
      bind -n M-8 select-window -t :=8
      bind -n M-9 select-window -t :=9

      # (prefix k) to kill window
      # unbind &
      # unbind C-k
      unbind k
      bind k confirm-before -p "Do you really want to kill #W? (y/n)"  kill-window

      set -g history-limit 10000

      # enable/disable synchronize input within a window
      bind a set-window-option synchronize-panes

      setw -g window-style 'bg=#2d2d2d'
      setw -g window-active-style "bg=#282828"
      setw -g pane-border-style "bg=#2d2d2d"

      # workaround for Alacritty opacity issue
      # set -g window-style 'fg=#EBDBB2'
      # set -g window-active-style 'fg=#EBDBB2'
    '';
    plugins = with pkgs.tmuxPlugins; [
      gruvbox
      sensible
      #nord
    ];
  };

  dconf.settings = {
     #"org/gnome/shell/extensions/user-theme" = {
     #   name = "Materia-light-compact";
     #};
     "org/gnome/mutter/keybindings" = {
         toggle-tiled-left = ["<Super>h"];
         toggle-tiled-right = ["<Super>l"];
     };
     "org/gnome/mutter" = {
       edge-tiling = true;
       attach-modal-dialogs = true;
     };
     "org/gnome/settings-daemon/plugins/media-keys" = {
         screensaver = ["<Super>Return"];
     };
     "org/gnome/desktop/background" = {
         picture-uri = "file:///home/taras/.local/share/backgrounds/wp1.png";
    };

    "org/gnome/desktop/interface" = {
         clock-format = "24h";
         clock-show-weekday = true;
         cursor-size = 32;

         document-font-name = "Iosevka 9";
         font-name = "Iosevka Term 10";
         #gtk-theme = "Materia-light-compact";
         monospace-font-name = "Iosevka Term 10";
    };
    "org/gnome/desktop/input-sources" = {
         per-window = true;
         sources = [
           (mkTuple ["xkb" "us"])
           (mkTuple ["xkb" "ru"])
         ];
         xkb-options = ["grp:shifts_toggle"];
     };
    "org/gnome/desktop/wm/preferences" = {
        action-middle-click-titlebar = "lower";
        titlebar-font = "Iosevka Term 10";
        titlebar-uses-system-font = true;
    };
    "org/gnome/desktop/wm/keybindings" = {
           maximize = ["<Super>k"];
           unmaximize = ["<Super>j"];
           minimize = ["<Super>apostrophe"];
           switch-to-workspace-1 = ["<Primary>1"]; # ctrl-1
           switch-to-workspace-2 = ["<Primary>2"]; # ctrl-2
           switch-to-workspace-3 = ["<Primary>3"]; # ctrl-3
           switch-to-workspace-4 = ["<Primary>4"]; # ctrl-4
     };
  };

  programs.gnome-terminal = {
    enable = true;
    showMenubar = false;
    themeVariant = "dark";
    profile = {
      "b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
        visibleName = "Grovbox";
        default = true;
        showScrollbar = false;
        font = "Iosevka 10";
        colors = {
          backgroundColor = "rgb(40,40,40)";
          foregroundColor = "rgb(235,219,178)";
          cursor = {
            background = "rgb(222,128,67)";
            foreground = "rgb(235,219,178)";
          };

          palette = [
            "rgb(40,40,40)" "rgb(204,36,29)"
            "rgb(152,151,26)" "rgb(215,153,33)"
            "rgb(69,133,136)" "rgb(177,98,134)"
            "rgb(104,157,106)" "rgb(168,153,132)"
            "rgb(146,131,116)" "rgb(251,73,52)"
            "rgb(184,187,38)" "rgb(250,189,47)"
            "rgb(131,165,152)" "rgb(211,134,155)"
            "rgb(142,192,124)" "rgb(235,219,178)"
          ];
        };
      };
    };

  };


  xresources.extraConfig = ''
    XTerm*faceSize: 9

    URxvt*scrollBar:        false
    URxvt*font:                 xft:Iosevka:size=4
    URxvt*iso14755:         false
    URxvt*iso14755_52:      false

    *.cursorColor: #de8043
    URxvt.cursorBlink: true

    URxvt.internalBorder: 16

    !!! Gruvbox theme
    ! hard contrast: *background: #1d2021
    *background: #282828
    ! soft contrast: *background: #32302f
    *foreground: #ebdbb2
    ! Black + DarkGrey
    *color0:  #282828
    *color8:  #928374
    ! DarkRed + Red
    *color1:  #cc241d
    *color9:  #fb4934
    ! DarkGreen + Green
    *color2:  #98971a
    *color10: #b8bb26
    ! DarkYellow + Yellow
    *color3:  #d79921
    *color11: #fabd2f
    ! DarkBlue + Blue
    *color4:  #458588
    *color12: #83a598
    ! DarkMagenta + Magenta
    *color5:  #b16286
    *color13: #d3869b
    ! DarkCyan + Cyan
    *color6:  #689d6a
    *color14: #8ec07c
    ! LightGrey + White
    *color7:  #a89984
    *color15: #ebdbb2

    ! Extended 256 color palette: requires 'rxvt-unicode-256xresources' package
    URxvt.color24:  #076678
    URxvt.color66:  #427b58
    URxvt.color88:  #9d0006
    URxvt.color96:  #8f3f71
    URxvt.color100: #79740e
    URxvt.color108: #8ec07c
    URxvt.color109: #83a598
    URxvt.color130: #af3a03
    URxvt.color136: #b57614
    URxvt.color142: #b8bb26
    URxvt.color167: #fb4934
    URxvt.color175: #d3869b
    URxvt.color208: #fe8019
    URxvt.color214: #fabd2f
    URxvt.color223: #ebdbb2
    URxvt.color228: #f2e5bc
    URxvt.color229: #fbf1c7
    URxvt.color230: #f9f5d7
    URxvt.color234: #1d2021
    URxvt.color235: #282828
    URxvt.color236: #32302f
    URxvt.color237: #3c3836
    URxvt.color239: #504945
    URxvt.color241: #665c54
    URxvt.color243: #7c6f64
    URxvt.color244: #928374
    URxvt.color245: #928374
    URxvt.color246: #a89984
    URxvt.color248: #bdae93
    URxvt.color250: #d5c4a1

  '';

}
