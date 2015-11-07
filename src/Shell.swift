class Shell {

    static func run(command: String) -> [String] {
        let task = NSTask()
        task.launchPath = "/bin/sh"

        task.arguments = ["-c", command]

        let pipe = NSPipe()
        task.standardOutput = pipe
        task.standardError = pipe

        let file = pipe.fileHandleForReading

        task.launch()

        task.waitUntilExit()

        let outputData = file.readDataToEndOfFile()
        let outputString = NSString(data: outputData, encoding: NSUTF8StringEncoding) as? String
        return outputString?.componentsSeparatedByString("\n") ?? []
    }
}
