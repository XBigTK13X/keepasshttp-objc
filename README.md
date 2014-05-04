### Usage
keepasshttp-objc exposes a KeePass client via HTTP. To implement this functionality, a developer needs to do the following.

1. Implement the protocol defined in [KPHKeePassClient](https://github.com/XBigTK13X/keepasshttp-objc/blob/master/keepasshttp-objc/Source/KPHKeePassClient.h)
2. Pass that implementation into a new instance of [KPHServer](https://github.com/XBigTK13X/keepasshttp-objc/blob/master/keepasshttp-objc/Source/KPHServer.h)

The server handles all network communication, and the KeePassClient leaves the heavy lifting to a KeePass compatible client (such as MacPass).

### Tips Working with the Browser Plugins
Testing changes to keepasshttp-objc against a browser requires a few steps. These methods return either plugin to a blank state.

#### Chrome
1. Delete all saved databases from the plguin admin page
2. Reload the plugin

#### Firefox
1. Disable the plugin
2. Restart the browser
3. Delete the saved key from the password manager
4. Enable the plugin
5. Restart the browser

### Important URLs
|Name|Purpose|Link|
|----|-------|----|
|Mono|Used as a reference for partial .NET reimplementations|https://github.com/mono/mono/tree/master/mcs/class/corlib/System|
|KeePass GitLab Mirror|Original project is hosted as a zipped source archive. This is easier to navigate|https://github.com/dlech/keepass2|
|KeePassHttp Plugins Repo|What this project interfaces with|https://github.com/pfn/passifox/
|KeePassHttp Repo|What is being rebuilt in Obj-C. A fork of kph, with better URL matching|https://github.com/mpern/keepasshttp
