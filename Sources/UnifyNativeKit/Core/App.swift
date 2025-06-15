@_exported import Foundation

@MainActor
public protocol App {
    associatedtype Body: View
    var body: Body { get }
    
    init()
    static func main()
}

@MainActor
public extension App {
    static func main() {
        print("🚀 App.main() started")
        
        // Create the app instance
        let app = Self()
        print("📱 Created app instance: \(app)")
        
        // Get the root view from the app's body
        let rootView = app.body
        print("🎨 Got root view: \(rootView)")
        
        // Start the application lifecycle
        print("⚡️ Starting ApplicationLifecycle...")
        ApplicationLifecycle.shared.start(rootView: rootView)
        
        print("✅ App.main() completed setup")
    }
} 