func packageApp(appPath: String, #deviceIdentifier: String, #outputPath: String?, #packageLauncherPath: String?, #fileManager: NSFileManager) {
    let sourcePath = appPath
        |> getFullPath
        >>= validateFileExistence(fileManager: fileManager)
    
    if let sourcePath = sourcePath {
        
        // TODO: Clean these two up in a functional way
        var targetPath: String
        if let outputPath = outputPath {
            targetPath = outputPath
        } else {
            targetPath = defaultTargetPathForApp(sourcePath)
        }
        
        var launcherPath: String
        if let packageLauncherPath = packageLauncherPath {
            launcherPath = packageLauncherPath
        } else {
            launcherPath =  "/usr/local/share/app-package-launcher"
        }
        
        let productFolder = "\(launcherPath)/build"
        let productPath = "\(productFolder)/Release/app-package-launcher.app"
        
        system("xcodebuild -project \(launcherPath)/app-package-launcher.xcodeproj \"PACKAGED_APP=\(sourcePath)\" \"TARGET_DEVICE=\(deviceIdentifier)\" > /dev/null")
        
        fileManager.removeItemAtPath(targetPath, error: nil)
        fileManager.moveItemAtPath(productPath, toPath: targetPath, error: nil)
        fileManager.removeItemAtPath(productFolder, error: nil)
        
        println("\(appPath) successfully packaged to \(targetPath)")
        
    } else {
        
        println("Provided .app not found at \(appPath)")
        
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

func defaultTargetPathForApp(appPath: String) -> String {
    let appName = (appPath
        |> URL)! // I don't know how to handle this nicer without introducing bunch of new types, we know the URL cannot fail, though
        |> lastPathComponent
        >>= deletePathExtension
    
    return "\(appName) Installer.app"
}