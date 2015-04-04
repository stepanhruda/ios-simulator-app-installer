import Foundation

struct PackagedApp {
    let filename: String
    
    var path: String {
        get {
            return pathForFileNamed(filename)!
        }
    }
    
    var bundleIdentifier: String {
        get {
            let infoPlist = NSDictionary(contentsOfFile: path.stringByAppendingString("/Info.plist"))
            return infoPlist?.objectForKey(kCFBundleIdentifierKey) as String
        }
    }
    
    init?(filename: String) {
        switch pathForFileNamed(filename) {
            case .Some: self.filename = filename
            case .None: return nil
        }
    }
    
    
}

func pathForFileNamed(filename: String) -> String? {
    return NSBundle.mainBundle().pathForResource(filename, ofType: "app")
}
