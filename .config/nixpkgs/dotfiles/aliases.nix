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

 cat = "bat";

 jq = "jq -C";

 vv = "vifm";

 screencast = "ffmpeg -f x11grab -s \"1920x1080\" -r \"60\" -i :1 -f alsa -ac 1 -i hw:2 -acodec libmp3lame -ab 128 -threads 8  ~/Videos/capture.mkv";
 screenweb = "mpv av://v4l2:/dev/video0 --profile=low-latency --untimed & sleep 1 && wmctrl -r \"video0\" -e 0,2000,1000,400,0 && wmctrl -r \"video0\" -b toggle,above && xprop -name 'video0 - mpv' -format _MOTIF_WM_HINTS 32i -set _MOTIF_WM_HINTS 2 && fg";
 screencam = "mpv av://v4l2:/dev/video2 --profile=low-latency --untimed --video-rotate=180 --video-zoom=0.33 & sleep 1 && wmctrl -r \"video2\" -b remove,maximized_vert,maximized_horz &&  wmctrl -r \"video2\" -e 0,0,2000,400,0 && wmctrl -r \"video2\" -b add,above && xprop -name 'video2 - mpv' -format _MOTIF_WM_HINTS 32i -set _MOTIF_WM_HINTS 2 && fg ";
 screenkey = "screenkey -p fixed -g 50%x7%+25%-1% -f \"Iosevka\"";

 vi = "nvim";
 vim = "nvim";
}
