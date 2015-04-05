> Create an OS X app that installs your iOS app into iOS Simulator.

(command line gif)

(GIF of double clicking an app and the simulator being launched)

Select a device when creating app installer, or on launch time.

(screenshot of UI to select simulator)

## Why use it?

* Install older builds without having to _git checkout_ and recompile everything

* Share simulator builds as OS X apps with members of your team

* Test version migrations faster by installing builds consecutively

## Installation

_ios-simulator-app-installer_ is distributed via [Homebrew](http://brew.sh).

```
brew tap stepanhruda/tap
brew install ios-simulator-app-installer
```

Latest stable version of Xcode and OS X Yosemite are required.

## Usage

__Example:__ `ios-simulator-app-installer --app "Rocket Science.app" --device "iPhone"`

* `--app`:

An app out of which the installer app is created. The easiest way to get a .app is by compiling your project using _xcodebuild_ and looking in _DerivedData/Build/Products/Debug-iphonesimulator_:

```
xcodebuild -workspace RocketScience.xcworkspace -scheme RocketScience -configuration Debug -derivedDataPath build/DerivedData -sdk iphonesimulator

ios-simulator-app-installer --app "build/DerivedData/Build/Products/Debug-iphonesimulator/Rocket Science.app"
```

* `--device`:

Restricts installing the app to certain simulators. Keep in mind these might not be available on someone else's machine or over time. If multiple devices match the string, the user shall select one.

A nice restriction example is `--device iPhone` or `--device iPad`. You can print your machine's currently available simulators via `--list-devices`.

* `--out`:

Output path where your installer shall be created. Default is _YourApp Installer.app_.

* `--list-devices`:

Lists out simulator identifiers available on your current machine.

* `--help`:

In case you get lost.

## Legal

MIT license in `LICENSE`. Icon from [designcontest.com](http://designcontest.com) under [CC](http://creativecommons.org/licenses/by/4.0/).