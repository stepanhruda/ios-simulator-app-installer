import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let filePath = NSBundle.mainBundle().pathForResource("Register", ofType: "app")
        
        if let filePath = filePath {
            let bundleIdentifier = "com.shopkeep.register"
            
            system("killall \"iOS Simulator\"")
            system("xcrun simctl shutdown booted")
            
            system("xcrun instruments -w \"iPad Air\"")
            
            system("xcrun simctl install booted \"\(filePath)\"")
            system("xcrun simctl launch booted \(bundleIdentifier)")
        }
        
        NSApplication.sharedApplication().terminate(self)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }

}

