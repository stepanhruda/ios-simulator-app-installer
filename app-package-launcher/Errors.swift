import Cocoa
import Foundation

let ErrorDomain = "com.stepanhruda.ios-simulator-app-installer"

public func appBundleNotFound() -> NSError {
    return  NSError(
        domain: ErrorDomain,
        code: 1,
        userInfo: [NSLocalizedDescriptionKey as NSString: "App bundle couldn't be found, this installer was packaged incorrectly."])
}

public func noSuitableDeviceFoundForString(targetDevice: String) -> NSError {
    return  NSError(
        domain: ErrorDomain,
        code: 2,
        userInfo: [NSLocalizedDescriptionKey as NSString: "No simulator matching \"\(targetDevice)\" was found."])
}

public func terminateWithError(error: NSError) {
    NSAlert(error: error).runModal()
    NSApplication.sharedApplication().terminate(nil)
}
