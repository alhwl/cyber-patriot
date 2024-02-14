# Close any running instances of Firefox
Get-Process firefox -ErrorAction SilentlyContinue | Stop-Process -Force

# Set preferences via about:config by appending to prefs.js in Firefox profile
$profilePath = Join-Path $env:APPDATA "Mozilla\Firefox\Profiles\*.default-release\prefs.js"

# Define the preferences to be added
$preferences = @(
    'user_pref("privacy.trackingprotection.enabled", true);',
    'user_pref("privacy.trackingprotection.socialtracking.enabled", true);',
    'user_pref("privacy.resistFingerprinting", true);',
    'user_pref("privacy.firstparty.isolate", true);',
    'user_pref("network.cookie.cookieBehavior", 1);',
    'user_pref("privacy.donottrackheader.enabled", true);',
    'user_pref("privacy.trackingprotection.fingerprinting.enabled", true);',
    'user_pref("privacy.trackingprotection.cryptomining.enabled", true);',
    'user_pref("browser.cache.offline.enable", false);',
    'user_pref("browser.send_pings", false);',
    'user_pref("browser.urlbar.speculativeConnect.enabled", false);',
    'user_pref("dom.event.clipboardevents.enabled", false);',
    'user_pref("geo.enabled", false);',
    'user_pref("media.navigator.enabled", false);',
    'user_pref("webgl.disabled", true);',
    'user_pref("browser.safebrowsing.downloads.remote.enabled", false);',
    'user_pref("browser.safebrowsing.malware.enabled", false);',
    'user_pref("browser.safebrowsing.phishing.enabled", false);',
    'user_pref("security.ssl.disable_session_identifiers", true);',
    'user_pref("media.eme.enabled", false);',
    'user_pref("media.gmp-widevinecdm.enabled", false);',
    'user_pref("browser.cache.disk.enable", false);',
    'user_pref("browser.cache.memory.enable", false);',
    'user_pref("browser.sessionstore.privacy_level", 2);',
    'user_pref("browser.privatebrowsing.autostart", true);',
    'user_pref("extensions.update.enabled", false);',
    'user_pref("xpinstall.signatures.required", true);',
    'user_pref("dom.disable_open_during_load", true);' # This line blocks popup windows
)

# Append preferences to prefs.js
foreach ($pref in $preferences) {
    Add-Content -Path $profilePath -Value $pref
}

# Launch Firefox
Start-Process "firefox.exe"
