class Xcode {

    static let requiredVersion = "Xcode 7"

    static func isRequiredVersionInstalled() -> Bool {
        guard let currentVersion = Xcode.currentVersion() else { return false }
        return currentVersion.hasPrefix(requiredVersion) && currentVersion >= requiredVersion
    }

    static func currentVersion() -> String? {
        return Shell.run("xcodebuild -version").first
    }
}
