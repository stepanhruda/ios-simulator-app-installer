import Cocoa
import Foundation

class Installer {

    static func installAndRunApp(packagedApp: PackagedApp, simulator: Simulator) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            shutDownCurrentSimulatorSessions()

            system("xcrun instruments -w \"\(simulator.identifierString)\"")

            system("xcrun simctl install booted \"\(packagedApp.bundlePath)\"")
            system("xcrun simctl launch booted \(packagedApp.bundleIdentifier)")

            NSApplication.sharedApplication().terminate(nil)
        }
    }

    static func shutDownCurrentSimulatorSessions() {
        system("killall \"iOS Simulator\"")
        system("xcrun simctl shutdown booted")
    }

}