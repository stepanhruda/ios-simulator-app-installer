import Foundation

enum PackagedAppError: ErrorType {
    case BundleNotFound
    case InfoPlistNotFound
    case BundleIdentifierNotFound

    var asNSError: NSError {
        let description: String
        switch self {
        case .BundleNotFound: description = "App bundle couldn't be found, this installer was packaged incorrectly."
        case .InfoPlistNotFound: description = "Info.plist not found in packaged app, this installer was packaged incorrectly."
        case .BundleIdentifierNotFound: description = "Bundle identifier not found in packaged app's Info.plist, this installer was packaged incorrectly."
        }

        return  NSError(
            domain: "com.stepanhruda.ios-simulator-app-installer",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey as NSString: description])
    }
}

struct PackagedApp {
    let bundleName: String
    let bundlePath: String
    let bundleIdentifier: String
    
    init(bundleName: String) throws {
        guard let bundlePath = PackagedApp.pathForFileNamed(bundleName) else { throw PackagedAppError.BundleNotFound }
        guard let infoPlist = PackagedApp.infoPlistInBundleWithPath(bundlePath) else { throw PackagedAppError.InfoPlistNotFound }
        guard let bundleIdentifier = PackagedApp.bundleIdentifierFromInfoPlist(infoPlist) else { throw PackagedAppError.BundleIdentifierNotFound }

        self.bundlePath = bundlePath
        self.bundleName = bundleName
        self.bundleIdentifier = bundleIdentifier
    }

    static func pathForFileNamed(filename: String) -> String? {
        return NSBundle.mainBundle().pathForResource(filename, ofType: "app")
    }

    static func infoPlistInBundleWithPath(bundlePath: String) -> NSDictionary? {
        return NSDictionary(contentsOfFile: bundlePath.stringByAppendingString("/Info.plist"))
    }

    static func bundleIdentifierFromInfoPlist(infoPlist: NSDictionary) -> String? {
        return infoPlist.objectForKey(kCFBundleIdentifierKey) as? String
    }
}
