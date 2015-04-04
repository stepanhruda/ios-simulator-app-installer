import Foundation

let RequiredXcodeVersion = "Xcode 6.2"

func isRequiredXcodeIsInstalled() -> Bool {
    return currentXcodeVersion() == RequiredXcodeVersion
}

func currentXcodeVersion() -> String? {
    return run("xcodebuild -version").first
}
