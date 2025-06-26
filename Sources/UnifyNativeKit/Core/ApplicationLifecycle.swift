@MainActor
public class ApplicationLifecycle {
    public static let shared = ApplicationLifecycle()
    private var isRunning = false
    
    public init() {
        print("🔄 ApplicationLifecycle initialized")
    }
    
    public func start<T: View>(rootView: T) {
        print("🎬 ApplicationLifecycle.start() called")
        guard !isRunning else {
            print("⚠️ Application already running!")
            return
        }
        isRunning = true
        
        // Here we would:
        // 1. Set up your platform-specific window/view hierarchy
        print("🪟 Creating window...")
        
        // 2. Configure the root view
        print("🎯 Configuring root view: \(rootView)")
        
        // 3. Start the platform-specific event loop
        print("🔄 Starting event loop...")
        
        // For now, we'll just keep the app running with a RunLoop
        print("⭐️ Entering RunLoop.current.run()")
        RunLoop.current.run()
        print("🛑 RunLoop ended") // This line should never be reached while app is running
    }
} 