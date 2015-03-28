func packageApp(appPath: String, deviceIdentifier: String) {
    let validPath =
    appPath
        |> getFullPath
        |> flatMap(validateFileExistence)
    
    if let validPath = validPath {
        system("xcodebuild -project app-package-launcher/app-package-launcher.xcodeproj \"PACKAGED_APP=\(validPath)\"")
        system("mv app-package-launcher/build/Release/app-package-launcher.app \"App Installer.app\"")
        system("rm -rf app-package-launcher/build")
        println("App packaged to App Installer.app")
    } else {
        fatalError("Provided .app not found at \(appPath)")
    }
}

func getFullPath(path: String) -> String? {
    return NSURL(fileURLWithPath: path)?.path
}

func validateFileExistence(path: String) -> String? {
    return NSFileManager.defaultManager().fileExistsAtPath(path) ? path : nil
}