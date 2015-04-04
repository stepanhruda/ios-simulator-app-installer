let (arguments, options) = parseArguments()

if arguments.displayHelp {
    
    options.printHelp()
    
} else if arguments.listDevices {
    
    printDevices()
    
} else if let appPath = arguments.appPath {
    
    packageApp(appPath,
        deviceIdentifier: arguments.deviceIdentifier,
        outputPath: arguments.outputPath,
        packageLauncherPath: arguments.packageLauncherPath,
        fileManager: NSFileManager.defaultManager())
    
} else {
    
    options.printHelp()
    
}
