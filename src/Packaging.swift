func packageApp(appPath: String, deviceIdentifier: String) {
    let validPath = appPath
        |> getFullPath
        >>= validateFileExistence(fileManager: NSFileManager.defaultManager())
    
    if let validPath = validPath {
        
        let appName = (validPath
            |> URL
            >>= lastPathComponent
            >=> deletePathExtension)! // There's a better way to do this than force unwrap
        
        let share = "/usr/local/share/"
        system("xcodebuild -project \(share)app-package-launcher/app-package-launcher.xcodeproj \"PACKAGED_APP=\(validPath)\" \"TARGET_DEVICE=\(deviceIdentifier)\" > /dev/null")
        system("rm -rf \"\(appName) Installer.app\"")
        system("mv \(share)app-package-launcher/build/Release/app-package-launcher.app \"\(appName) Installer.app\"")
        system("rm -rf \(share)app-package-launcher/build")
        
        println("\(appName) successfully packaged to \"\(appName) Installer.app\"")
    } else {
        
        println("Provided .app not found at \"\(appPath)\"")
        
    }
}

func getFullPath(path: String) -> String? {
    return URL(path)?.path
}

func validateFileExistence(#fileManager: NSFileManager)(path: String) -> String? {
    return fileManager.fileExistsAtPath(path) ? path : nil
}

func lastPathComponent(#url: NSURL) -> String? {
    return url.lastPathComponent
}

func URL(path: String) -> NSURL? {
    return NSURL.fileURLWithPath(path)
}

func deletePathExtension(path: String) -> String? {
    return path.stringByDeletingPathExtension
}