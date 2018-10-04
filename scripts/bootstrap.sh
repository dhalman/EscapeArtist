cp `dirname "$0"`/../res/com.escapeartist.plist ~/Library/LaunchAgents/
mkdir -p /usr/local/bin
cp `dirname "$0"`/../bin/EscapeArtist /usr/local/bin
launchctl load -w ~/Library/LaunchAgents/com.escapeartist.plist
launchctl start com.escapeartist
