{
  git-fuck-everything =
    "git-abort ; git reset . ; git checkout . ; git clean -f -d";

 ll = "exa -lah --group-directories-first --color=always --icons ";
 l = "exa -lh --group-directories-first --color=always --icons ";
 k = "kubectl";
 grep = "rg";
 g = "rg";

 dark = "xprop -f _GTK_THEME_VARIANT 8u -set _GTK_THEME_VARIANT \"dark\"";
 hide = "xprop -f  _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS '0x2, 0x0, 0x0, 0x0, 0x0'";

 cat = "bat --theme=gruvbox-dark";
 duf = "duf -theme ansi";

 jq = "jq -C";

 vv = "vifm";

 screencast = "ffmpeg -f x11grab -s \"1920x1080\" -r \"60\" -i :1 -f alsa -ac 1 -i hw:2 -acodec libmp3lame -ab 128 -threads 8  ~/Videos/capture.mkv";

 screenweb = "v4l2-ctl -v width=1920,height=1080,pixelformat=UYVY -p 60 -d /dev/v4l/by-path/pci-0000:03:00.3-usb-0:1.1.1:1.0-video-index0 && mpv av://v4l2:/dev/v4l/by-path/pci-0000:03:00.3-usb-0:1.1.1:1.0-video-index0  --profile=low-latency --untimed & sleep 1 && xprop -name 'pci-0000:03:00.3-usb-0:1.1.1:1.0-video-index0 - mpv' -format _MOTIF_WM_HINTS 32i -set _MOTIF_WM_HINTS 2 && wmctrl -r \"pci-0000:03:00.3-usb-0:1.1.1:1.0-video-index0\" -e 0,3370,1330,600,0 && wmctrl -r \"pci-0000:03:00.3-usb-0:1.1.1:1.0-video-index0\" -b toggle,above && fg";

 screencam = "v4l2-ctl -v width=1920,height=1080,pixelformat=YUYV -d /dev/v4l/by-path/pci-0000:47:00.1-usb-0:3.3:1.0-video-index0 && mpv av://v4l2:/dev/v4l/by-path/pci-0000:47:00.1-usb-0:3.3:1.0-video-index0 --profile=low-latency --untimed --video-rotate=180 --video-zoom=0.33 & sleep 1 && wmctrl -r \"pci-0000:47:00.1-usb-0:3.3:1.0-video-index0\" -b remove,maximized_vert,maximized_horz &&  wmctrl -r \"pci-0000:47:00.1-usb-0:3.3:1.0-video-index0\" -e 0,0,2000,400,0 && wmctrl -r \"pci-0000:47:00.1-usb-0:3.3:1.0-video-index0\" -b add,above && xprop -name 'pci-0000:47:00.1-usb-0:3.3:1.0-video-index0 - mpv' -format _MOTIF_WM_HINTS 32i -set _MOTIF_WM_HINTS 2 && fg ";

 screenkey = "screenkey -p fixed -g 50%x7%+25%-1% -f \"Iosevka\"";

 vi = "nvim";
 vim = "nvim";
 urxvt = "urxvt -fn \"xft:Iosevka:size=12\"";

 contribution = "git ls-files | xargs -n1 git blame --line-porcelain | sed -n 's/^author //p' | sort -f | uniq -ic | sort -nr";
 multitail = "multitail -F ~/.multitail.conf";
}
