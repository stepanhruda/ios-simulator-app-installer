import Foundation

struct Simulator {
    var identifierString: String
    
    static func create(identifierString: String) -> Simulator {
        return Simulator(identifierString: identifierString)
    }
}

func simulatorsMatchingIdentifier(identifier: String) -> [Simulator] {
    return allSimulators()
        |> filteredWithPredicate(matchesIdentifier(identifier))
}

func matchesIdentifier(identifier: String)(simulator: Simulator) -> Bool {
    switch count(identifier) {
    case 0: return true
    default: return (simulator.identifierString as NSString).containsString(identifier)
    }
}

func allSimulators() -> [Simulator] {
    return run("xcrun instruments -s")
        |> filteredWithPredicate { ($0 as NSString).containsString("Simulator") }
        |> map(truncateUuid)
        |> sorted { $0 > $1 }
        |> map(Simulator.create)
}

func truncateUuid(string: String) -> String {
    let index = advance(string.endIndex, -38)
    return string.substringToIndex(index)
}
