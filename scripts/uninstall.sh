launchctl unload -w ~/Library/LaunchAgents/com.escapeartist.plist
launchctl stop com.escapeartist || echo "EscapeArtist service is not running"
rm ~/Library/LaunchAgents/com.escapeartist.plist
rm /usr/local/bin/EscapeArtist
