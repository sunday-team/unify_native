import ArgumentParser
import Foundation
import UnifyNativeKit

@main
struct UnifyCLI: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "unify",
        abstract: "A CLI tool for managing UnifyNative projects",
        version: "1.0.0",
        subcommands: [
            New.self,
            Build.self,
            Run.self
        ]
    )
}

// Command to create a new UnifyNative project
extension UnifyCLI {
    struct New: ParsableCommand {
        static let configuration = CommandConfiguration(
            commandName: "new",
            abstract: "Create a new UnifyNative project"
        )
        
        @Argument(help: "Name of the project")
        var name: String
        
        @Option(name: .shortAndLong, help: "Target platforms (ios, android, web)")
        var platforms: [String] = ["ios", "android"]
        
        func run() throws {
            print("Creating new UnifyNative project: \(name)")
            print("Target platforms: \(platforms.joined(separator: ", "))")
            
            // Create project directory
            let projectDir = FileManager.default.currentDirectoryPath + "/" + name
            try FileManager.default.createDirectory(atPath: projectDir, withIntermediateDirectories: true)
            
            // Create Package.swift
            let packageContent = """
                // swift-tools-version: 6.1
                import PackageDescription
                
                let package = Package(
                    name: "\(name)",
                    dependencies: [
                        .package(path: "../") // Path to UnifyNative
                    ],
                    targets: [
                        .executableTarget(
                            name: "\(name)",
                            dependencies: ["UnifyNativeKit"]
                        )
                    ]
                )
                """
            try packageContent.write(toFile: projectDir + "/Package.swift", atomically: true, encoding: .utf8)
            
            // Create main.swift
            let mainContent = """
                import UnifyNativeKit
                
                @main
                @MainActor
                struct \(name)App: App {
                    init() {}
                    
                    var body: ContentView {
                        ContentView()
                    }
                }
                
                @MainActor
                struct ContentView: View {
                    var body: VStack {
                        VStack {
                            Text("Welcome to \(name)!").padding(10).font(.title)
                            Button("Click Me") {
                                print("Button clicked")
                            }
                        }
                    }
                }
                """
            try FileManager.default.createDirectory(atPath: projectDir + "/Sources", withIntermediateDirectories: true)
            try mainContent.write(toFile: projectDir + "/Sources/main.swift", atomically: true, encoding: .utf8)
            
            print("✅ Project created successfully at \(projectDir)")
        }
    }
    
    struct Build: ParsableCommand {
        static let configuration = CommandConfiguration(
            commandName: "build",
            abstract: "Build the UnifyNative project"
        )
        
        @Flag(name: .shortAndLong, help: "Build in release mode")
        var release: Bool = false
        
        func run() throws {
            print("Building project...")
            let process = Process()
            
            #if os(Windows)
            process.executableURL = URL(fileURLWithPath: "swift")
            #else
            process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
            #endif
            
            process.arguments = ["swift", "build"] + (release ? ["-c", "release"] : [])
            try process.run()
            process.waitUntilExit()
            
            if process.terminationStatus == 0 {
                print("✅ Build successful")
            } else {
                throw ValidationError("❌ Build failed")
            }
        }
    }
    
    struct Run: ParsableCommand {
        static let configuration = CommandConfiguration(
            commandName: "run",
            abstract: "Run the UnifyNative project"
        )
        
        @Flag(name: .shortAndLong, help: "Run in release mode")
        var release: Bool = false
        
        func run() throws {
            print("Running project...")
            let process = Process()
            
            #if os(Windows)
            // Find Swift executable path on Windows
            let swiftPathProcess = Process()
            swiftPathProcess.executableURL = URL(fileURLWithPath: "where.exe")
            swiftPathProcess.arguments = ["swift"]
            
            let pipe = Pipe()
            swiftPathProcess.standardOutput = pipe
            try swiftPathProcess.run()
            swiftPathProcess.waitUntilExit()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let swiftPath = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "swift"
            
            process.executableURL = URL(fileURLWithPath: swiftPath)
            #else
            process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
            #endif
            
            process.arguments = ["swift", "run"] + (release ? ["-c", "release"] : [])
            try process.run()
            process.waitUntilExit()
            
            if process.terminationStatus != 0 {
                throw ValidationError("❌ Run failed")
            }
        }
    }
} 