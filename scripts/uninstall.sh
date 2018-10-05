launchctl unload -w ~/Library/LaunchAgents/com.escapeartist.plist
launchctl stop com.escapeartist 
rm ~/Library/LaunchAgents/com.escapeartist.plist
rm /usr/local/bin/EscapeArtist
echo "EscapeArtist service is stopped, unloaded, and uninstalled"
