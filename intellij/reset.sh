reset_jetbrains() {
  rm ~/Library/Preferences/$1*/eval/*evaluation.key
  rm ~/Library/Preferences/$1*/options/options.xml
  open ~/Library/Preferences/com.apple.java.util.prefs.plist
}
