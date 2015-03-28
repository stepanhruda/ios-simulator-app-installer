import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let filePath = NSBundle.mainBundle().pathForResource("Packaged", ofType: "app")
        
        let simulator = "iPad Air"
        
        if let filePath = filePath {
            let infoPlist = NSDictionary(contentsOfFile: filePath.stringByAppendingString("/Info.plist"))
            let bundleIdentifier = infoPlist?.objectForKey(kCFBundleIdentifierKey) as String

            system("killall \"iOS Simulator\"")

            system("xcrun simctl shutdown booted")
            
            system("xcrun instruments -w \"\(simulator)\"")
            
            system("xcrun simctl install booted \"\(filePath)\"")
            system("xcrun simctl launch booted \(bundleIdentifier)")
        } else {
            fatalError("App wasn't bundled correctly")
        }

        NSApplication.sharedApplication().terminate(self)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }

}

