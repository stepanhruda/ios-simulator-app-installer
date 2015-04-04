import Cocoa
import Foundation

class SimulatorSelectionWindowController: NSWindowController {
    
    @IBOutlet weak var selectionPopUpButton: NSPopUpButton!
    
    var onFinished: (String -> Void)?
    var simulators: [String]!
    
    class func controller(simulators: [String], onFinished: String -> Void) -> SimulatorSelectionWindowController {
        let controller = SimulatorSelectionWindowController(windowNibName: "SimulatorSelection")
        controller.simulators = simulators
        controller.onFinished = onFinished
        return controller
    }
    
    override func windowDidLoad() {
        selectionPopUpButton.removeAllItems()
        selectionPopUpButton.menu = NSMenu(title: "Simulators")
        selectionPopUpButton.addItemsWithTitles(simulators)
    }
    
    @IBAction func launchTapped(sender: NSButton) {
        if let selectedSimulator = selectionPopUpButton.selectedItem?.title {
            close()
            onFinished?(selectedSimulator)
        } else {
            NSApplication.sharedApplication().terminate(sender)
        }
    }
    
    @IBAction func cancelTapped(sender: NSButton) {
        NSApplication.sharedApplication().terminate(sender)
    }
    
}
