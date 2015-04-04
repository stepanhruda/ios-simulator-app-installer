func printDevices() {
    supportedInstrumentsConfigurations()
        |> filterLinesContainingSimulator
        |> map(truncateUuid)
        |> sorted { $0 > $1 }
        |> map(println)
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

func truncateUuid(string: String) -> String {
    let index = advance(string.endIndex, -38)
    return string.substringToIndex(index)
}
