import AppKit
import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(notification: NSNotification) {
        do {
            let packagedApp = try PackagedApp(bundleName: "Packaged")

            let simulatorIdentifierProvidedOnCompileTime = Parameters.deviceString()
            let simulators = Simulator.simulatorsMatchingIdentifier(simulatorIdentifierProvidedOnCompileTime)

            switch simulators.count {

            case 1:

                Installer.installAndRunApp(packagedApp, simulator: simulators.first!)

            case _ where simulators.count > 1:

                letUserSelectSimulatorFrom(simulators) { selectedSimulator in
                    Installer.installAndRunApp(packagedApp, simulator: selectedSimulator)
                }

            default:

                terminateWithError(noSuitableDeviceFoundForStringError(simulatorIdentifierProvidedOnCompileTime))
            }
        }
        catch let error as PackagedAppError {
            terminateWithError(error.asNSError)
        } catch {
            fatalError("error handling failure")
        }
    }
    
    var simulatorSelectionController: SimulatorSelectionWindowController?

    func letUserSelectSimulatorFrom(simulators: [Simulator], completion: Simulator -> Void) {
        simulatorSelectionController = SimulatorSelectionWindowController.controller(simulators) {
            [unowned self] selectedSimulator in
            completion(selectedSimulator)
            self.simulatorSelectionController = nil
        }
        simulatorSelectionController?.showWindow(nil)
    }

    func terminateWithError(error: NSError) {
        NSAlert(error: error).runModal()
        NSApplication.sharedApplication().terminate(nil)
    }

    func noSuitableDeviceFoundForStringError(targetDevice: String) -> NSError {
        return  NSError(
            domain: "com.stepanhruda.ios-simulator-app-installer",
            code: 2,
            userInfo: [NSLocalizedDescriptionKey as NSString: "No simulator matching \"\(targetDevice)\" was found."])
    }
}
