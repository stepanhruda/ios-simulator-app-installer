func linesContainingSimulator(lines: [String]) -> [String] {
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