xcodebuild -workspace src/ios-simulator-app-installer.xcworkspace -scheme ios-simulator-app-installer -archivePath ios-simulator-app-installer/ archive

cp ios-simulator-app-installer.xcarchive/Products/usr/local/bin/ios-simulator-app-installer ios-simulator-app-installer

rm -rf ios-simulator-app-installer.xcarchive
