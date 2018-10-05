EscapeArtist
===================

For anyone who wants ESC keycode when CTRL is tapped, but wants to keep standard modifier behavior on CTRL. (Macbook Pro Touchbar + Vim?)

The implementation is based on event listening and non-blocking run loops (as opposed to timers and polling current state). It should not adversely affect keyboard or processor performance in any measurable fashion. 

Based on Activity Monitor, it typically shows 0% CPU Utilization and ~3MB of RAM.

Usage:
1) Auto runs on install and restart.
2) Tap CTRL to fire ESC command. 
3) Any additional key down or modifier change will cancel ESC action and act as normal CTRL modifier.

Installation:
1) Download/Clone package
2) Execute `./scripts/bootstrap.sh`
3) (Sometimes Required) Accessbility permissions - When prompted, open accessibilty preferences and check the box next to EscapeArtist to allow ESC keycode globally. Feel free to test without installing permissions to see if necessary on your system.

Uninstallation:
1) Execute `./scripts/uninstall.sh`
2) (Optional) Remove Downloaded/Cloned package

Note:
This program does not use any network or disk I/O. It does not log/save/report any information regarding user data, keystroke history, or storage filesystem. Feel free to read the (very short) source code to confirm for yourself.

Feel free to modify the source code for your own needs, but I ask that you please do not use this software or any modification of it for the purpose of spying, stealing, or otherwise compromising the security of any computer or network.

<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.
