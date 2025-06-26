// Export Foundation types
@_exported import Foundation

/// The main protocol for defining views in UnifyNative
@MainActor
public protocol View {
    associatedtype Body: View
    var body: Body { get }
} 