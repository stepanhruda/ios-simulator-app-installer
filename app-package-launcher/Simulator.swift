struct Simulator {
    let identifierString: String

    static func allSimulators() -> [Simulator] {
        return Shell.run("xcrun instruments -s")
            .filterSimulators()
            .map { $0.truncateUuid() }
            .sort { $0 > $1 }
            .map { Simulator(identifierString: $0) }
    }

    static func simulatorsMatchingIdentifier(identifier: String) -> [Simulator] {
        let all = allSimulators()
        guard identifier.characters.count > 0 else { return all }
        return all.filter { simulator in
            return simulator.identifierString.containsString(identifier)
        }
    }
}

extension CollectionType where Generator.Element == String {
    func filterSimulators() -> [String] {
        return filter { $0.containsString("iPhone") || $0.containsString("iPad") }
    }
}

extension String {
    func truncateUuid() -> String {
        let endMinus38 = endIndex.advancedBy(-38)
        return substringToIndex(endMinus38)
    }
}