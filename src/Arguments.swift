let AppFlag = "app"
let DeviceFlag = "device"
let OutFlag = "out"
let PackageLauncherFlag = "package-launcher"
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
    
    var outputPath: String? {
        get { return objectForKey(OutFlag) as? String }
    }
    
    var packageLauncherPath: String? {
        get { return objectForKey(PackageLauncherFlag) as? String }
    }
}

func parseArguments() -> (Arguments, GBOptionsHelper) {
    let arguments = Arguments(name: "CommandLine", parent: nil)
    let parser = GBCommandLineParser()
    let options = GBOptionsHelper()
    
    options.registerSeparator("NEW INSTALLER")
    options.registerOption("a".cChar(), long: AppFlag, description: ".app for the installer", flags: .RequiredValue)
    options.registerOption("d".cChar(), long: DeviceFlag, description: "restrict installer to certain simulators, will be matched with --list-devices on launch", flags: .RequiredValue)
    options.registerOption("o".cChar(), long: OutFlag, description: "output path for the created installer", flags: .RequiredValue)
    options.registerSeparator("DEVICES")
    options.registerOption("l".cChar(), long: ListDevicesFlag, description: "list currently available device identifiers", flags: .NoValue)
    options.registerSeparator("HELP")
    options.registerOption("h".cChar(), long: HelpFlag, description: "print out this help", flags: .NoValue)
    options.registerOption("p".cChar(), long: PackageLauncherFlag, description: "use a path for app-package-launcher instead of the default in /usr/local/share", flags: .RequiredValue | .Invisible)
    
    parser.registerSettings(arguments)
    parser.registerOptions(options)
    
    parser.parseOptionsUsingDefaultArguments()
    
    return (arguments, options)
}