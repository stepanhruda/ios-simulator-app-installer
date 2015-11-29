Command-line tool to create an OS X app with your iOS Simulator app packaged in. The result looks like this:

<img src="https://cloud.githubusercontent.com/assets/2835783/7115770/8b984222-e1b9-11e4-9eec-70a6ae16260d.png" width="124" height="135">

When you open it, it launches iOS Simulator and installs the packaged iOS app.

## Why use it?

* Install older builds without having to _git checkout_ and recompile everything

* Share simulator builds as OS X apps with members of your team

* Test version migrations faster by installing builds consecutively

## Installation

_ios-simulator-app-installer_ is distributed via [Homebrew](http://brew.sh).

```
brew tap stepanhruda/ios-simulator-app-installer https://github.com/stepanhruda/ios-simulator-app-installer
brew install ios-simulator-app-installer
```

Latest stable version of Xcode and OS X Yosemite are required.

## Usage

__Example:__ `ios-simulator-app-installer --app "Rocket Science.app" --device "iPhone"`

* `--app`

An app out of which the installer app is created. The easiest way to get a .app is by compiling your project using _xcodebuild_ and looking in _DerivedData/Build/Products/Debug-iphonesimulator_:

```
xcodebuild -workspace RocketScience.xcworkspace -scheme RocketScience -configuration Debug -derivedDataPath build/DerivedData -sdk iphonesimulator

ios-simulator-app-installer --app "build/DerivedData/Build/Products/Debug-iphonesimulator/Rocket Science.app"
```

* `--device`

Restricts installing the app to certain simulators. Keep in mind your selection might not be available on someone else's machine or over time.

If multiple devices match your string, the user will be prompted to select one.

<img src="https://cloud.githubusercontent.com/assets/2835783/7115847/316417a8-e1ba-11e4-9c17-b632583cf404.png" width="472" height="233">

* `--fresh-install`

A fresh install of the app on every installer launch. This is helpful if you want to blow away the local storage or e.g. clean NSUserDefaults on every launch.

* `--out`

Output path where your installer shall be created. Default is _YourApp Installer.app_.

* `--list-devices`

Lists out simulator identifiers available on your current machine.

* `--help`

In case you get lost.

## Legal

MIT license in `LICENSE`. Icon from [designcontest.com](http://designcontest.com) under [CC](http://creativecommons.org/licenses/by/4.0/).
