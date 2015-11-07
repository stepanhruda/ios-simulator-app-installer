let arguments = Arguments(name: "CommandLine", parent: nil)
let options = arguments.parse()

if arguments.displayHelp {
    
    options.printHelp()
    
} else if arguments.listDevices {
    
    Simulator.allSimulators().forEach { print($0.identifierString) }
    
} else if let appPath = arguments.appPath {

    do {
        try Packaging.packageAppAtPath(appPath,
            deviceIdentifier: arguments.deviceIdentifier,
            outputPath: arguments.outputPath,
            packageLauncherPath: arguments.packageLauncherPath,
            fileManager: NSFileManager.defaultManager())
    } catch let error as PackagingError {
        print(error.message)
    }
    
} else {
    
    options.printHelp()
    
}
