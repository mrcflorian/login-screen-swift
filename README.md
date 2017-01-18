## About

This is a simple Swift 3 implementation of a Login Screen. It has support for signing in with
Facebook and Twitter, as well as the classic email & password form.

The template uses FacebookLogin and TwitterKit frameworks.

## Installation and configuration

First, you need to clone this repository, in order to fetch the code

```
$ git clone https://github.com/mrcflorian/login-screen-swift.git
```

In order to compile your code, you need to install the dependencies first (in our case, the
frameworks from Twitter and Facebook). You can simply do this by running the following command
in the root folder of the project (where the Pods file lives):

```
$ pod install
```

If you're not familiar with Cocoapods, <a href="https://guides.cocoapods.org/using/getting-started.html">checkout their website</a>, to see how you can install it.


Once the pods were installed properly, open LoginScreen.xcworkspace with Xcode and run the project.

Everything should be working fine. There's one more thing to do though, since the code is using
some default Facebook & Twitter applications. You need to update the code so that it uses your apps.

Open the Info.plist file (as source code) and update the following piece of code with your correct
API keys:

```
<array>
		<dict>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>fb285315185217069</string>
			</array>
		</dict>
	</array>
	<key>CFBundleVersion</key>
	<string>1</string>
	<key>Fabric</key>
	<dict>
		<key>APIKey</key>
		<string>7189842e0edc1f648a6e6e3c52978493bb12c759</string>
		<key>Kits</key>
		<array>
			<dict>
				<key>KitInfo</key>
				<dict>
					<key>consumerKey</key>
					<string>9p0SO3sGDAhHu7uz5g9BF9on0</string>
					<key>consumerSecret</key>
					<string>7ozjHdTpgY3Szejy0R1rYZtFeIjMB50krpbba7b5ShVawlSxeP</string>
				</dict>
				<key>KitName</key>
				<string>Twitter</string>
			</dict>
		</array>
	</dict>
	<key>FacebookAppID</key>
	<string>285315185217069</string>
	<key>FacebookDisplayName</key>
	<string>iOSAppTemplates</string>
	<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>fbapi</string>
		<string>fb-messenger-api</string>
		<string>fbauth2</string>
		<string>fbshareextension</string>
	</array>

```

## Documentation

The interface of the login screen can be found in Interface/LoginScreen.storyboard. The template uses auto layout contraints, to display the UI elements.

The core class is LoginViewController, which contains all the logic for the three different types of authentication. The code is pretty short and easy to understand.

If you want even more details on the project, please visit <a href="http://iosapptemplates.com/templates/login-screen-in-swift-3-freebie/">iOS App Templates</a>.
