let (arguments, options) = parseArguments()

if arguments.displayHelp {
    
    options.printHelp()
    
} else if arguments.listDevices {
    
    printDevices()
    
} else if arguments.appPath != nil && arguments.deviceIdentifier != nil {
    
    packageApp(arguments.appPath!,
        deviceIdentifier: arguments.deviceIdentifier!,  // TODO: Remove force unwraps with Swift 1.2 support
        outputPath: arguments.outputPath,
        packageLauncherPath: arguments.packageLauncherPath,
        fileManager: NSFileManager.defaultManager())
    
} else {
    
    options.printHelp()
    
}
