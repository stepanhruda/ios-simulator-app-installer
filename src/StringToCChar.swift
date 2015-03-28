extension String {
    func cChar() -> CChar {
        return cStringUsingEncoding(NSUTF8StringEncoding)!.first!
    }
}