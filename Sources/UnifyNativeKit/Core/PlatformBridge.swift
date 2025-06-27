import Foundation

#if os(Android)
// Import des types C
@_silgen_name("get_jni_env")
func _get_jni_env() -> UnsafeMutableRawPointer?

public class PlatformBridge {
    public static let shared = PlatformBridge()
    
    private init() {}
    
    public var jniEnv: UnsafeMutableRawPointer? {
        return _get_jni_env()
    }
    
    public func startApplication() {
        print("🚀 Starting application from Swift")
        
        // Vérifier que nous avons bien l'environnement JNI
        guard let _ = jniEnv else {
            print("❌ Failed to get JNI environment")
            return
        }
        
        // Démarrer le cycle de vie de l'application
        ApplicationLifecycle.shared.start(rootView: App())
    }
}
#endif 