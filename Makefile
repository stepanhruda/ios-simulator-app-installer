ios-simulator-app-installer: ios-simulator-app-installer.xcarchive
	cp $</Products/usr/local/bin/$@ $@
	rm -rf $<

ios-simulator-app-installer.xcarchive:
	xcodebuild -workspace src/ios-simulator-app-installer.xcworkspace\
		-scheme ios-simulator-app-installer\
		-archivePath ios-simulator-app-installer/ archive

