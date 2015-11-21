enum PackagingError: ErrorType {
    case RequiredXcodeUnavailable(String)
    case InvalidAppPath(String)
    case XcodebuildFailed
    case FileWriteFailed(NSError)

    var message: String {
        switch self {
        case .RequiredXcodeUnavailable(let requiredVersion):
            return "You need to have \(requiredVersion) installed and selected via xcode-select."
        case .InvalidAppPath(let path):
            return "Provided .app not found at \(path)"
        case .XcodebuildFailed:
            return "Error in xcodebuild when packaging app"
        case .FileWriteFailed(let error):
            return "Writing output bundle failed: \(error.localizedDescription)"
        }
    }
}

class Packaging {

    static func packageAppAtPath(
        appPath: String,
        deviceIdentifier: String?,
        outputPath outputPathMaybe: String?,
        packageLauncherPath packageLauncherPathMaybe: String?,
        fileManager: NSFileManager) throws {
            let packageLauncherPath = packageLauncherPathMaybe ?? "/usr/local/share/app-package-launcher"

            guard Xcode.isRequiredVersionInstalled() else { throw PackagingError.RequiredXcodeUnavailable(Xcode.requiredVersion) }
            guard fileManager.fileExistsAtPath(appPath) else { throw PackagingError.InvalidAppPath(appPath) }
            let fullAppPath = NSURL(fileURLWithPath: appPath).path!

            let outputPath = outputPathMaybe ?? defaultOutputPathForAppPath(appPath)

            let productFolder = "\(packageLauncherPath)/build"
            let productPath = "\(productFolder)/Release/app-package-launcher.app"
            let packagedAppFlag = "\"PACKAGED_APP=\(fullAppPath)\""
            let targetDeviceFlag = deviceIdentifier != nil ? "\"TARGET_DEVICE=\(deviceIdentifier!)\"" : ""

            let xcodebuildExitCode =
            system("xcodebuild -project \(packageLauncherPath)/app-package-launcher.xcodeproj \(packagedAppFlag) \(targetDeviceFlag) > /dev/null")
            guard xcodebuildExitCode == 0 else { throw PackagingError.XcodebuildFailed }

            do {
                if fileManager.fileExistsAtPath(outputPath) {
                    try fileManager.removeItemAtPath(outputPath)
                }
                try fileManager.moveItemAtPath(productPath, toPath: outputPath)
                try fileManager.removeItemAtPath(productFolder)
            } catch let error as NSError {
                throw PackagingError.FileWriteFailed(error)
            }

            print("\(appPath) successfully packaged to \(outputPath)")
    }

    static func defaultOutputPathForAppPath(appPath: String) -> String {
        let url = NSURL(fileURLWithPath: appPath)
        let appName = url.URLByDeletingPathExtension?.lastPathComponent ?? "App"
        return "\(appName) Installer.app"
    }

}
