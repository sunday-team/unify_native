public enum Unify {
    public typealias UnifyFont = Font
    
    @MainActor
    public class VStack: View {
        public typealias Body = VStack
        public var body: Body { self }
        
        public var children: [any View]
        
        public init(@UnifyViewBuilder content: () -> [any View]) {
            self.children = content()
        }
    }

    @MainActor
    public class Text: View {
        public typealias Body = Text
        public var body: Body { self }
        
        public var text: String
        public var paddingValue: Int = 0
        public var fontValue: UnifyFont = .body
        
        public init(_ text: String) {
            self.text = text
        }
        
        public func padding(_ value: Int) -> Text {
            self.paddingValue = value
            return self
        }
        
        public func font(_ font: UnifyFont) -> Text {
            self.fontValue = font
            return self
        }
    }

    @MainActor
    public class Button: View {
        public typealias Body = Button
        public var body: Body { self }
        
        public var text: String
        public var onClick: () -> Void
        
        public init(_ text: String, onClick: @escaping () -> Void) {
            self.text = text
            self.onClick = onClick
        }
    }
    
    public enum Font {
        case body
        case title
        case headline
    }
}

@resultBuilder
public struct UnifyViewBuilder {
    public static func buildBlock(_ components: any View...) -> [any View] {
        return components
    }
} 