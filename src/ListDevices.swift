func printDevices() {
    supportedInstrumentsConfigurations()
        |> filterLinesContainingSimulator
        |> printDeviceLines
}

func supportedInstrumentsConfigurations() -> [String] {
    return run("xcrun instruments -s")
}

func filterLinesContainingSimulator(lines: [String]) -> [String] {
    return lines |> filteredWithPredicate {
        string in
        let nsstring = string as NSString
        return nsstring.containsString("Simulator")
    }
}

func printDeviceLines(devices: [String]) {
    if devices.count > 0 {
        for line in devices {
            println(line)
        }
    } else {
        println("No devices found.")
    }
}
