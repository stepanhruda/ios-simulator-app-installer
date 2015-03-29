func packageApp(appPath: String, deviceIdentifier: String) {
    let validPath =
    appPath
        |> getFullPath
        |> flatMap(validateFileExistence)
    
    if let validPath = validPath {
        let share = "/usr/local/share/"
        system("xcodebuild -project \(share)app-package-launcher/app-package-launcher.xcodeproj \"PACKAGED_APP=\(validPath)\" > /dev/null")
        system("rm -rf \"App Installer.app\"")
        system("mv \(share)app-package-launcher/build/Release/app-package-launcher.app \"App Installer.app\"")
        system("rm -rf \(share)app-package-launcher/build")
        println("App successfully packaged to \"App Installer.app\"")
    } else {
        println("Provided .app not found at \"\(appPath)\"")
    }
}

func getFullPath(path: String) -> String? {
    return NSURL(fileURLWithPath: path)?.path
}

func validateFileExistence(path: String) -> String? {
    return NSFileManager.defaultManager().fileExistsAtPath(path) ? path : nil
}