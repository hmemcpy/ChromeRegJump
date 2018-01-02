<img src="https://raw.githubusercontent.com/hmemcpy/ChromeRegJump/master/src/regedit-logo.png" width="64" align="right" />

Chrome Registry Jumper
====

Chrome extension to open any selected Windows Registry path in Registry Editor using [Sysinternals RegJump](https://technet.microsoft.com/en-us/sysinternals/bb963880.aspx).

<a href="https://chrome.google.com/webstore/detail/chome-registry-jumper/ihjgnaklogcickonfphakiihgjpkdheh"><img src="https://developer.chrome.com/webstore/images/ChromeWebStore_Badge_v2_340x96.png" alt="Available in the Chrome Web Store"/></a>

## Installation instructions

**Windows 7 users**: This extension requires PowerShell 3, please download and install PowerShell 3 for your OS architecture:
 * 32-bit: http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.1-KB2506143-x86.msu
 * 64-bit: http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.1-KB2506143-x64.msu

After installing the extension, a page with instructions will open. You have to follow the instructions, otherwise this extension **won't work**!

You will need to navigate to where the extension is installed (e.g. `%LOCALAPPDATA%\Google\Chrome\User Data\Default\Extensions\ihjgnaklogcickonfphakiihgjpkdheh\1.0.1_0\host\`) and run the file `register-host.bat`. This will enable the native host app that communicates with RegJump.

In addition, you will have to download RegJump and place it in the `regjump` folder.

## How does it work?

The main goal of this extension is to send the selected text on a page (which should be a registry path, e.g. `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT`) to a utility from Sysinternals called [RegJump](https://technet.microsoft.com/en-us/sysinternals/bb963880.aspx), which handles the actual opening regedit and jumping to the specified key.

However, it is not possible to launch 3<sup>rd</sup> party executables from Chrome directly - that's not allowed for very good reasons. 

Previously, it was possible to use [NPAPI](http://en.wikipedia.org/wiki/NPAPI) to host a native plugin in Chrome (like Java or Silverlight), but that was deprecated, and as of recently, [removed from Chrome completely](http://blog.chromium.org/2014/11/the-final-countdown-for-npapi.html).

This leaves only one option - using Chrome's [Native Messaging](https://developer.chrome.com/extensions/nativeMessaging). The idea is, the *user* registers a native host app (by adding a key to the registry) which communicates with Chrome by passing messages (json). The native host app can then do whatever it is programmed to do.

In this extension, the native host app is a PowerShell script which takes in the selected text from Chrome, and launches `regjump.exe` (which the user also has to download himself and put in the specified folder), passing it the selected text.

If RegJump can parse this text as a valid registry path, it will launch regedit with the specified path (like jumping to path in Procmon).

Finally, since Regedit requires elevation to launch, you will always get a UAC popup asking you to confirm before launching the actual `regedit.exe`.

![](http://i.imgur.com/RKibz8P.png)

### Bugs? Questions? Suggestions?

Please feel free to [report them](../../issues) and send a pull request!

![](http://i.imgur.com/U6PJlH8.gif)
