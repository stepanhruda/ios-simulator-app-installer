let (arguments, options) = parseArguments()

if arguments.displayHelp {
    
    options.printHelp()
    
} else if arguments.listDevices {
    
    run("xcrun instruments -s")
        |> linesContainingSimulator
        |> printDeviceLines
    
} else if arguments.appPath != nil && arguments.deviceIdentifier != nil {
    
    packageApp(arguments.appPath!, arguments.deviceIdentifier!)
    
} else {
    
    options.printHelp()
    
}


