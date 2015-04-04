import AppKit
import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let packagedApp = PackagedApp(filename: "Packaged")

        switch packagedApp {
        case .Some(let packagedApp):
            
            let simulatorIdentifierProvidedOnCompileTime = TargetDevice.deviceString()
            let simulators = simulatorsMatchingIdentifier(simulatorIdentifierProvidedOnCompileTime)

            switch simulators.count {
                
            case 1:
                
                installAndRunApp(packagedApp, simulator: simulators.first!)
                
            case _ where simulators.count > 1:
                
                letUserSelectSimulator(simulators) { selectedSimulator in
                    installAndRunApp(packagedApp, simulator: selectedSimulator)
                }
                
            default:
                
                terminateWithError(noSuitableDeviceFoundForStringError(simulatorIdentifierProvidedOnCompileTime))
                
                }
            
        case .None:
            
            terminateWithError(appBundleNotFoundError())
            
        }
    }
    
    var simulatorSelectionController: SimulatorSelectionWindowController?
    
    func letUserSelectSimulator(simulators: [Simulator], completion: Simulator -> Void) {
        simulatorSelectionController = SimulatorSelectionWindowController.controller(simulators) {
            [unowned self] selectedSimulator in
            completion(selectedSimulator)
            self.simulatorSelectionController = nil
        }
        simulatorSelectionController?.showWindow(nil)
    }
}
