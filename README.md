<p align="center">
    <a href="http://iosapptemplates.com/templates/login-screen-in-swift-3-freebie/"><img src="http://iosapptemplates.com/wp-content/uploads/2017/01/ios-login-screen-template-swift-3.png" width="25%" alt = "iOS Login Screen in Swift"/></a>
</p>

**This project has been updated to Swift 5 and Xcode 11.2**

## About

This is a simple <a href="https://www.iosapptemplates.com/templates/iphone-login-screen-template-swift-3-freebie">iOS login screen written in Swift 5</a>. It has support for <b>signing in with
Facebook, Google and specially Apple</b>, as well as the classic email & password form.

The template uses FacebookLogin and GoogleSignin frameworks, installed with Cocoapods.

## Installation and configuration

First, you need to clone this repository, in order to fetch the code

```
$ git clone https://github.com/mrcflorian/login-screen-swift.git
```

In order to compile your code, you need to install the dependencies first (in our case, the
frameworks from Twitter and Facebook). You can simply do this by running the following command
in the root folder of the project (where the Pods file lives):

```
$ pod update
```

If you're not familiar with Cocoapods, <a href="https://guides.cocoapods.org/using/getting-started.html">checkout their website</a>, to see how you can install it.


Once the pods were installed properly, open <b>LoginScreen.xcworkspace</b> with Xcode and run the project.

Everything should be working fine. There's one more thing to do though, since the code is using
some default Facebook & Google applications. You need to update the code so that it uses your apps.

Open the <b>Info.plist</b> file (as source code) and update the following piece of code with your correct
API keys:

```
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>fb285315185217069</string>
        </array>
    </dict>
</array>
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
    <string>twitter</string>
    <string>twitterauth</string>
</array>

```
For Sign in with apple, you need to configure something on Certificates, Identifiers and Profiles. 
https://www.iosapptemplates.com/blog/ios-development/sign-in-with-apple-swift 
Check out the link above and do step 1 and step 2.

## Documentation

The interface of the login screen can be found in Interface/LoginScreen.storyboard. The template uses auto layout contraints, to display the UI elements.

The core class is LoginViewController, which contains all the logic for the three different types of authentication. The code is pretty short and easy to understand.

If you want even more details on the project, please visit <a href="http://iosapptemplates.com/templates/login-screen-in-swift-3-freebie/">iOS App Templates</a>.
