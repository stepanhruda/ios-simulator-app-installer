import Foundation

let RequiredXcodeVersion = "Xcode 6.3"

func isRequiredXcodeIsInstalled() -> Bool {
    
    if let comparationResult = currentXcodeVersion()?.localizedCaseInsensitiveCompare(RequiredXcodeVersion) {
        switch comparationResult {
        case .OrderedDescending, .OrderedSame: return true
        default: ()
        }
    }
    return false
}

func currentXcodeVersion() -> String? {
    return run("xcodebuild -version").first
}

