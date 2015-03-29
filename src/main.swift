let (arguments, options) = parseArguments()

if arguments.displayHelp {
    
    options.printHelp()
    
} else if arguments.listDevices {
    
    printDevices()
    
} else if arguments.appPath != nil && arguments.deviceIdentifier != nil {
    
    packageApp(arguments.appPath!, arguments.deviceIdentifier!) // TODO: Remove force unwrap with Swift 1.2 support
    
} else {
    
    options.printHelp()
    
}
