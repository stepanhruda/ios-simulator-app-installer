import AppKit
import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var simulatorSelectionController: SimulatorSelectionWindowController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let filePath = NSBundle.mainBundle().pathForResource("Packaged", ofType: "app")
        
        if let filePath = filePath {
            let infoPlist = NSDictionary(contentsOfFile: filePath.stringByAppendingString("/Info.plist"))
            let bundleIdentifier = infoPlist?.objectForKey(kCFBundleIdentifierKey) as String
            let targetDevice = TargetDevice.deviceString()
            let simulators = simulatorMatchingString(targetDevice)

            switch simulators.count {
            case 1:
                
                installAndRunApp(filePath, bundleIdentifier: bundleIdentifier, device: targetDevice)
                
            case _ where simulators.count > 1:
                
                letUserSelectSimulator(simulators) { selectedSimulator in
                    installAndRunApp(filePath, bundleIdentifier: bundleIdentifier, device: selectedSimulator)
                }
                
            default:
                
                terminateWithError(noSuitableDeviceFoundForString(targetDevice))
                
            }
        } else {
            terminateWithError(appBundleNotFound())
        }
    }
    
    func letUserSelectSimulator(simulators: [String], completion: String -> Void) {
        simulatorSelectionController = SimulatorSelectionWindowController.controller(simulators, onFinished: completion)
        simulatorSelectionController?.showWindow(nil)
    }
}

public func cleanUpDirtyState() {
    system("killall \"iOS Simulator\"")
    system("xcrun simctl shutdown booted")
}

public func simulatorMatchingString(string: String) -> [String] {
    return run("xcrun instruments -s")
        |> filteredWithPredicate { ($0 as NSString).containsString(string) }
        |> map(truncateUuid)
}

public func truncateUuid(string: String) -> String {
    let index = advance(string.endIndex, -38)
    return string.substringToIndex(index)
}

public func installAndRunApp(appPath: String, #bundleIdentifier: String, #device: String) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
        cleanUpDirtyState()
        
        system("xcrun instruments -w \"\(device)\"")
        
        system("xcrun simctl install booted \"\(appPath)\"")
        system("xcrun simctl launch booted \(bundleIdentifier)")
        
        NSApplication.sharedApplication().terminate(nil)
    }
}


