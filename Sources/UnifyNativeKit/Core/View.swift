@MainActor
public protocol View {
    associatedtype Body: View
    var body: Body { get }
} 