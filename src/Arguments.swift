let AppFlag = "app"
let DeviceFlag = "device"
let ListDevicesFlag = "list-devices"
let HelpFlag = "help"

class Arguments: GBSettings {
    var displayHelp: Bool {
        get { return isKeyPresentAtThisLevel(HelpFlag) }
    }
    
    var listDevices: Bool {
        get { return isKeyPresentAtThisLevel(ListDevicesFlag) }
    }
    
    var appPath: String? {
        get { return objectForKey(AppFlag) as? String }
    }
    var deviceIdentifier: String? {
        get { return objectForKey(DeviceFlag) as? String }
    }
}

func parseArguments() -> (Arguments, GBOptionsHelper) {
    let arguments = Arguments(name: "CommandLine", parent: nil)
    let parser = GBCommandLineParser()
    let options = GBOptionsHelper()
    
    options.registerSeparator("PACKAGING")
    options.registerOption("a".cChar(), long: AppFlag, description: ".app to be packaged", flags: .RequiredValue)
    options.registerOption("d".cChar(), long: DeviceFlag, description: "identifier for device on which .app will be launched, e.g. \"iPhone 6\"", flags: .RequiredValue)
    options.registerSeparator("DEVICES")
    options.registerOption("l".cChar(), long: ListDevicesFlag, description: "list currently available device identifiers", flags: .NoValue)
    options.registerSeparator("MISC")
    options.registerOption("h".cChar(), long: HelpFlag, description: "print out this help", flags: .NoValue)
    
    parser.registerSettings(arguments)
    parser.registerOptions(options)
    
    parser.parseOptionsUsingDefaultArguments()
    
    return (arguments, options)
}