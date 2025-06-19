// Export Foundation types
@_exported import Foundation

// Define the ViewBuilder
@resultBuilder
@MainActor
public enum UnifyViewBuilder {
    public static func buildBlock(_ components: any View...) -> any View {
        if components.count == 1 {
            return components[0]
        }
        return VStack {
            components[0]
        }
    }
    
    public static func buildExpression(_ expression: any View) -> any View {
        return expression
    }
    
    public static func buildOptional(_ component: (any View)?) -> any View {
        return component ?? EmptyView()
    }
    
    public static func buildEither(first component: any View) -> any View {
        return component
    }
    
    public static func buildEither(second component: any View) -> any View {
        return component
    }
    
    public static func buildArray(_ components: [any View]) -> any View {
        return VStack {
            components[0] // For now, just use the first component
        }
    }
}

@MainActor
public struct EmptyView: View {
    public init() {}
    public var body: some View { self }
}

// Re-export all components at the top level for convenience
public typealias VStack = UnifyComponents.VStack
public typealias Text = UnifyComponents.Text
public typealias Button = UnifyComponents.Button
public typealias Font = UnifyComponents.Font

// Re-export the ViewBuilder
public typealias ViewBuilder = UnifyViewBuilder 