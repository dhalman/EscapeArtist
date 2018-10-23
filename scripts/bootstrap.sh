#Install config
mkdir -p ~/Library/LaunchAgents
cp `dirname "$0"`/../res/com.escapeartist.plist ~/Library/LaunchAgents/ || echo "Failed to create config" && exit 1

#Install binary
mkdir -p /usr/local/bin
cp `dirname "$0"`/../bin/EscapeArtist /usr/local/bin || echo "Failed to install binary" && exit 1

#Setup auto launch
launchctl load -w ~/Library/LaunchAgents/com.escapeartist.plist
launchctl start com.escapeartist && echo "Escape artist is installed! If not running, please try restarting system" || "Installation failed, please try again or create an issue on the github repository: https://github.com/dhalman/EscapeArtist"
